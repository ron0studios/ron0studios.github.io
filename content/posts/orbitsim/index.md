---
title: "OrbitSim"
lead: "Orbit simulations using Barnes-Hut"
date: 2024-03-01
slug: "orbitsim"
description: "My "
keywords: ["simulation", "physics", "orbit", "barnes-hut"]
draft: false
tags: ["c++", "scientific", "project", "cpu"]
math: true
toc: true
summary: My implementation of the Barnes-Hut treecode algorithm for N-body gravity simulations. Capable of hosting up to 100k bodies on low end devices.
---

> THIS IS A DRAFT!
> This current article is still *very much under construction* and may need some more time to be fully ironed out! Please hang tight for the moment!

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
but the same formulas laid out way back in `1667`[^1].

[^1]: [By Isaac Newton himself in *Philosophiæ Naturalis Principia Mathematica*](https://en.wikipedia.org/wiki/Newton%27s_law_of_universal_gravitation).


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




## Barnes-Hut treeocde algorithm

## Tuning + Optimisation

## Showcase
