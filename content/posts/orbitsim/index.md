---
title: "OrbitSim"
lead: "Orbit simulations using Barnes-Hut"
date: 2024-03-01
slug: "orbitsim"
description: "C++ CPU implementation of a realtime Barnes-Hut treecode algorithm."
keywords: ["simulation", "physics", "orbit", "barnes-hut"]
draft: false
tags: ["c++", "scientific", "project", "cpu"]
math: true
toc: true
summary: My implementation of the Barnes-Hut treecode algorithm for N-body gravity simulations. Capable of hosting up to 100k bodies on CPU devices.
---

{{< video src="demo.mp4" type="video/mp4"  width="50%" anchor="right" wrap="true" ops="controls autoplay muted loop" 
caption="`Orbitsim in action.` Plus a <span style='opacity:50%'>(slow)</span> Quadtree visual!"
>}}

There's something deeply satisfying in simulating the real world. With a simple set of rules it's surprisingly easy to create something 
with **emergent structure**. 

This applies to a lot of concepts: Boids, Markets, RL games, automata -- but something that really interested me was `physics`. 
Not to say that physics is built on simple rules - we don't even know what the rules that truly govern nature really are yet. 
**However,** we have pretty good approximations :)

This is a post on an old project I worked on during my A-Level days, but something I've always enjoyed tinkering with and improving over the years.

[__**OrbitSim**__](https://github.com/ron0studios/OrbitSim) is an N-body particle simulator designed to run on simple, *cpu-based* hardware. 
Using various optimisations, it can simulate up to `50,000` particles on a mid-range **8-core laptop**. With this many particles, using nothing
but the same formulas laid out way back in [`1667`](https://en.wikipedia.org/wiki/Newton%27s_law_of_universal_gravitation).


---
---

## Quick background 

The **Law of Universal Gravitation** states that the gravitational force between two bodies is as follows:

$$
F=\frac{Gm_{1}m_{2}}{r^{2}}
$$

where **$m_1$** and **$m_2$** are the respective masses of both bodies and **$r$** being the distance between them. $G$ is the **Gravitational Constant**

The forces are *equal and opposite* (sounds familiar!), and the total force applied to a body $x$ is simply the **sum of all pairs $(x,y\in \text{Bodies})$**. 
I.e. add up all the forces between $x$ and every *other* body and we now know the total force to apply to *x*.

Our *step-function* will be the amount we should move our body, given the **total** force acted on it.

$$
\begin{aligned}
\textbf{accel} &= \frac{\text{F}_{\text{total}}}{\text{mass}} \\
\textbf{vel}_{\text{new}} &= \text{vel}_{\text{old}} + (\textbf{accel} \cdot \Delta t) \\
\textbf{pos}_{\text{new}} &= \text{pos}_{\text{old}} + (\textbf{vel}_{\text{new}} \cdot \Delta t)
\end{aligned}
$$

Here, $\Delta t$ is our **time-step** -- the total time between serving our old position/velocity/force values and recalculating our new ones. 

{{< svg src="forces.svg" width="50%" anchor="center" wrap="false"
caption="The total force on an object is the sum of all pairs to all other objects"
>}}

---

### Too slow!

So we've established that to step forward a particle in our simulation, we need to loop through every other particle in the simulation, and 
accumulate a total force from the pairs. 

```cpp
// this is pseudocode!
for(int i = 0; i < NUM_BODIES; i++) {
    Vec2 total_force = 0;
    for(int j = i+1; j < NUM_BODIES; j++) {
        Vec2 total_force += Force(Bodies[i], Bodies[j]);
    }
    Bodies[i].force = total_force;
}
```

This is a $O(\frac{N(N-1)}{2})=O(N^2)$ calculation. per-timestep. **yikes**. Here's a quick table for scale.

| N (bodies) | Interactions: $O(\frac{N(N-1)}{2})$ | 
| ---------- | ----------------------------- | 
|          1 |                             0 | 
|          2 |                             1 | 
|          5 |                            10 | 
|         10 |                            45 | 
|        100 |                         4,950 | 
|      1,000 |                       499,500 | 
|     10,000 |                    49,995,000 | 

On my laptop, things start falling apart at **~1k bodies**.

---
---

## Barnes-Hut treecode algorithm

For larger simulations, we definitely need to move away from this method. 

From this point on, we will be working with algorithms that trade off *accuracy* for **speed**. 
Algorithms that help scale these simulations work on how we can **approximate** our steps, ensuring
all bodies are treated correctly and self-organise as they would in a perfect simulation.

---

### Thinking in `Groups`

We don't *necessarily* have too much repetition in this method, but there is a 
huge disparity in the **contribution** of each body to our total force. 

Looking back at [the formula](#quick-background), the amount of force added by a 
body attenuates fast at an `inverse square rate`. 

Perhaps we could "ignore" these tiny contributions -- thereby reducing the amount of pairs we need to compute?

The problem with just ignoring bodies at a certain cutoff, however, is that a lot of minor contributors 
**together** can produce a non-negligible pull on the body.

Think about a simple Earth-Moon diagram: without the Earth the Moon spirals off into space, 
without the Moon the Earth is [also impacted](https://youtu.be/M3sofzVzpt0?si=aoMAY15dp4rAjB-r). 

What about a random star in the Andromeda Galaxy? Regardless of how massive a star might be, the inverse square distance of 2.5 **million**
light years is enough to make the pairwise force negligible. 
{{< svg src="galaxyscale.svg" width="100%" anchor="center" wrap="false"
caption="Several small contributions from a distant object can match that of a close body."
>}}
<br>

But the *Andromeda Galaxy itself* exerts a strong enough pull to the Earth for it, and the rest of the Milky Way, at `300km/s`. 

So clearly if we had started cutting off individual stars from that galaxy, we would be ignoring the **collective** impact of the cluster as a whole. 

A fast and accurate approximation therefore is to **group** clusters of close-by but negligible bodies and **treat them as one object**. 
We skip the pairwise calculation of each child of the object, and only compute once. 

This is the primary concept of the **Barnes-Hut Approximation**. 

1. Create a fast lookup for *groups* of close-by bodies
2. For each body:
    1. Calculate **direct** pairwise forces for close objects
    2. Calculate **indirect** approximations for far away clusters 
    3. Update new Force.
3. Standard timestep. 
4. **repeat.**

---

### The **QuadTree**

{{< svg src="quadtree.svg" width="50%" anchor="center" wrap="false"
caption="An example QuadTree. Not all leaves **need** to contain a body."
>}}
<br>
The crux of determining whether this is feasible, is if we can find a **fast** way of looking up clusters. 

The solution is the **QuadTree** -- in $O(log(n))$ time we can lookup bodies by location, and view them in meaningful groups.

The premise of the QuadTree is *hierarchy*. We start with some predefined bounds (OrbitSim for example uses 10 Million AU).
The tree begins as an empty single node defined by these bounds.

#### Nodes

Each **Node** of the tree can be classified as either `internal` (containing children) or `external` (leaf containing `0` or `1` children). 

Since Nodes can be used to **group** related bodies, we can maintain some more useful metadata, such as the **centre of mass** of that node, 
or the number of total bodies contained within the node. 

```cpp
    struct node {
        int child   = 0; // the index of the first child of the node.
        double mass = 0.0; // the total mass of the node and its children
        double width = 0.0; // the width of the node


        // center of mass calculations
        int total   = 0; // total bodies of the node
        double massx = 0.0; // x position of center of mass
        double massy = 0.0; // y position of center of mass

        // if node has 1 child
        Body* singleChild = nullptr; // pointer to singleChild body

        double cx = 0.0; // x position of the center of the node
        double cy = 0.0; // y position of the center of the node
    };
```

Internally the nodes for a QuadTree (in OrbitSim) are stored *consecutively*. We use a neat trick involving heaps
to store the tree format as **a single contiguous array**. 

For 4 children, for each node at cell `x`, the first child of that node can have exclusive access to cell `4x+1`, 
the second `4x+2`, and so on. 

{{< svg src="heap.svg" width="50%" anchor="center" wrap="false"
caption="For example with 2 children. <br>Node `x`. Child: `2x+1`, Child: `2x+2`"
>}}

#### Construction 

The construction of the tree is done by looping through every body and inserting them into the tree, **creating new branches**
when we wind up with more than one body occupying a single `external` node. 

Note that the "splitting" process creating new branches does not necessarily happen only once per move! If two bodies are close 
enough, they may need to split multiple times before moving forward. Remember the purpose of this step is to guarantee every leaf 
node has **either 0 or 1 bodies**.

{{< svg src="construction.svg" width="100%" anchor="center" wrap="false"
>}}

#### Invocation

We need to figure out how we can use the QuadTree to calculate total force on some node `x`.

The rough algorithm for this would be:
1. Start at the root node
2. If the node is `external` we perform a regular pair-wise calculation.
3. If this node meets a `threshold` we treat it as a single body.
    - We use the *centre of mass* as our basis for the body.
4. If the node *fails* the threshold:
    - We perform a **depth-first search** on the child nodes


Our `threshold` in this case is the **ratio between the node width and distance to the main body**.

$$
\theta= \frac{\text{Node Width}}{|\text{Node Position}-\text{Body Position}|}
$$

This is also another handy reason to keep a *centre of mass* as metadata for our nodes. Without this 
property we would be assuming the **centre-point** of the node as our basis for $\theta$ as well as 
the "approximate body". 

```cpp
// recursively updates the force of a given body
// using the quadtree and an approximation factor, theta
void QuadTree::updateForce(Body * body, double theta) {

  // since we need to traverse the quadtree we create a stack to backtrack and
  // move deeper into the tree
  std::stack < int > stack;
  stack.push(0);
  body -> acceleration = {
    0.0,
    0.0
  }; // reset the previous acceleration of the body

  // while the stack still contains items we pop
  // from the top of the stack and process it
  while (!stack.empty()) {
    int idx = stack.top();
    stack.pop();
    node n = tree[idx];

    if (n.mass == 0) continue; // check if empty node

    // calculate theta (width/distance). if we're under the threshold we approximate
    if (n.child > 0) {
      double distance = sqrt(pow(n.massx - body -> position.x, 2) 
                        + pow(n.massy - body -> position.y, 2));
      double ratio = n.width / (distance);

      if (ratio <= theta) {

        sf::Vector2 < double > accel = forcePair(body -> mass,
          n.mass,
          body -> position,
          sf::Vector2 < double > (n.massx, n.massy)) / body -> mass;

        body -> acceleration += accel;
      } else {
        for (int i = 0; i < 4; i++) {
          stack.push(n.child + i);
        }
      }
    } else {
      // if the node has no children then it must have a singleBody.
      // We simply calculate the force between body and singleBody.
      if (n.singleChild == body) continue;

      sf::Vector2 < double > accel = forcePair(body -> mass,
        n.singleChild -> mass,
        body -> position,
        n.singleChild -> position) / body -> mass;

      body -> acceleration += accel;
    }
  }

}
```

### Concisely 

To quickly wrap up this pretty long explanation. **For each frame:**

1. We **construct** the QuadTree by looping through the bodies.
2. *For each body*, we calculate its **new** force by **traversing** the QuadTree.
3. *For each body*, we calculate its **new** velocity and position using its new force.

Since the QuadTree reduces a lot of previously linear per-body calculations to **logarithmic**, our
time complexity has dropped from $O(N^2)$ to **$O(Nlog(N))$**.

## Showcase

With the optimisation of Barnes-Hut, we're able to run on over `50,000 bodies` in `30fps` **real time**. 

Tuning the approximation threshold and allowing for more cores can scale this up to `100,000` bodies in real time.

Given a gpu, more compute, and headless execution, we could *potentially* get this to run on `millions` of bodies.

here are a couple demo images of galaxies rendered using **OrbitSim**.

  {{< grid gap="1rem" >}}
    {{< img src="galaxy.png" width="100%" caption="50,000 bodies. Galaxy spirals <br>**~30fps**" >}}
    {{< img src="nebula.png" width="calc(50% - 0.5rem)" caption="80,000 bodies. Nebulae <br>**25-28fps**" >}}
    {{< img src="orbit.png" width="calc(50% - 0.5rem)" caption="20,000 bodies. Natural orbiting <br> **60fps**" >}}
    {{< img src="universe.png" width="80%" caption="100,000 bodies. <br> **20fps**" >}}
  {{< /grid >}}

---
---

## Summary

There's a lot of other things to talk about in this project, e.g. rendering, UI, optimisations/profiling <span style="opacity: 0.5">(Tracy!!)</span> -- perhaps this could be the topic of another post.

Thanks for reading!

### **__[You can find the code here on GitHub](https://github.com/ron0studios/OrbitSim)__**
