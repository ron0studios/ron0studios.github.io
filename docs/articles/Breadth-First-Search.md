# BFS

----

## Overview

**Breadth First Search** is an *iterative, graph traversal algorithm*. It relies on **queues** to manage which nodes it will be traversing to, alongside information on which nodes have already been *visited*. Similar to [DFS](https://rudrrayan.github.io/#/articles/Depth-First-Search.md), *BFS* is one of the most popular graph traversal algorithms, with the hidden benefit of solving for **single source shortest distance** problem, which we will look into later!

> **Quick tip:** use an STL queue in c++ to run the algorithm more specifically (maybe even faster)!

---

## Process 

Unlike [DFS](https://rudrrayan.github.io/#/articles/Depth-First-Search.md), **BFS** is entirely *iterative*, meaning that we are able to break out of the algorithm much more easily, effective for many problems. As it's name suggests, the algorithm acts **breadth first**, traversing the graph *layer by layer* outwards from the source. It can convert a graph into a tree (*essentially*), with the leaf nodes being the furthest from the source.

As for the prerequisites, we need a way of storing our visited Nodes. This article will be using a hash-map, but there are many different options to go for when storing your data, not limited to a map/hash-map! We also need a queue, to store all the nodes we will be processing in each iteration. Most STL arrays, or c style arrays will suffice for most situations, but it is highly recommended that you use an **[std::queue](https://en.cppreference.com/w/cpp/container/queue)** for this algorithm, since it is much more specific to the context of the situation.

Firstly, we will take our source node, **A**, and mark it as *visited*. We then push it to our *queue*. Now, while our queue has some leftover processes, *hence not being empty*, we will carry out the following actions:

- We mark the first node of the queue, the front, as visited and remove that element. 
- We push each of this node's neighbours to the queue, marking them as visited, *only if they haven't been visited yet*

In this way, each node that adds all its neighbours to the queue, only get those nodes traversed to *when all the nodes in its layer are finished*, therefore taking a *layer by layer* approach to traversing the graph. Because of this approach, we are able to extrapolate the *shortest path*, from a given source to *all other nodes*, since the first time a node gets traversed via *BFS*, the layer at which the node is at, *must* be the shortest viable path from the source. **Be careful that this method does not work with weights or negative cycles!**

Here is some C++ pseudo-code to help demonstrate:

```clike
//C++ pseudo-demonstration
void BFS(Node A, unordered_map<Node,bool> visited, queue<Node> q)
{
    q.push(A);
    visited[A] = true;
    while(!q.empty())
    {
        Node B = q.front(); q.pop();
        for(auto i : B.neighbours)
        {
            if(visited[i] == false)
            {
                visited[i] = true;
                q.push(i);
            }
        }
    }
}
```

---

## How to find distance from start node 

We've seen how to traverse a given graph via *BFS*, but it still may not be clear how we can actually find out *what layer each node is from the respected source*, therefore being unable to extract the shortest path from the graph. The best way to get the shortest distance from all nodes from a given source would be to store a separate hash-map/map containing all the nodes and their *level* from the source, essentially their distance. Every time a node gets en-queued, we will find this node and set its level to the level of the node that it comes from *+1*. essentially, we can take this as a form of **tabulation**, a dynamic programming technique, filling in a sort of table with each node to its matching level, based on the receiving node's level plus one. 

Here is some C++ pseudo-code to help demonstrate:

```clike
//C++ pseudo-demonstration + level tracking
void BFS(Node A, unordered_map<Node,bool> visited, queue<Node> q)
{
    q.push(A);
    visited[A] = true;
    unordered_map<Node,int> distance;
    distance[A] = 0; // the level of "A" is set to 0 as default
    
    while(!q.empty())
    {
        Node B = q.front(); q.pop();
        for(auto i : B.neighbours)
        {
            if(visited[i] == false)
            {
                visited[i] = true;
                distance[i] = distance[B]+1;
                q.push(i);
            }
        }
    }
    // you can return the distance hashmap here if you want
}
```



---

## Time Complexity

> Exactly like [DFS](https://rudrrayan.github.io/#/articles/Depth-First-Search.md), Breadth First Search has a time complexity of **O(V+E)**, where **V** is the number of *nodes (vertices)*, and **E** is the number of *connections (edges)*. Here is an explanation on how this works:

In a worst case scenario, we would have a **"complete graph"**, one in which every node is connected to every other node. Sort of like a pentagram! In *BFS*, by the end of the algorithm, every node will end up getting traversed, and each edge gets checked, therefore we can say:

> **O( V<sub>0</sub> + All of V<sub>0</sub>'s edges + V<sub>1</sub> + All of V<sub>1</sub>'s edged [...] )**

which can be simplified to:

> **O( (V<sub>0</sub> + V<sub>1</sub> + [...] ) + ( E<sub>0</sub> + E<sub>1</sub> + [...]) )**

since each edge only gets visited once throughout the algorithm! A graph, by definition, is a pairwise data structure, so two nodes can't have the same edge going off of it. We can finally simplify this to:

> **O( All vertices + All edges )** or **O(V+E)**

------

## The Simulation

Here is a simulation, *written in [Godot](godotengine.org)*, that goes through the algorithm for **BFS** discussed in this chapter. You can insert/delete nodes, add edges, and move around. Here is a quick tutorial on how to use it:

- Move around by dragging your mouse
- Double click to create a node, or destroy one. 
- Right click on a node to create an edge from it, right click on another node afterwards. (**Do not do this whilst the simulation is running!**)
- press escape while holding an edge to cancel that action
- *middle click on a node to start the simulation*
- change the speed of the simulation with the slider
- **If the program crashes, please report it!!!** 

<iframe src="https://itch.io/embed-upload/3380811?color=333333" allowfullscreen="" width="1024" height="620" frameborder="0"><a href="https://ron0studios.itch.io/bfs">Play BFS on itch.io</a></iframe>
