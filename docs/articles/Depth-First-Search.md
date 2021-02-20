# **DFS**

## Overview

**Depth First Search**, or **DFS**, is a *recursive, graph traversal algorithm*. It follows the principal of **backtracking** to find all nodes reachable from a given source. It is often seen as the *simplest graph traversal algorithm*, but can be used practically in nearly every graph question you find online. 

> **Quick tip:** on [Codeforces](www.codeforces.com), around 1/ 10 problems require you to use DFS in order to solve the problem, that's over 600!

---

## Process (Pure DFS)

As mentioned earlier, Depth First Search is a backtracking algorithm. We begin with the starting node **A**, which will act as our source. We then loop through all of the connections the nodes makes, and traverse to that node recursively. We keep following this path until we reach a node that *makes no connections*. We then backtrack automatically and continue the loop from the parenting node. With this method, we will have gone through all possible nodes that are reachable from **A**

Here is some C++ pseudocode to help demonstrate:

```clike
//C++ pseudo-demonstration
void DFS(Node node) //the node class simply contains an array of all its neighbours and its data value (an integer)
{
    for(auto i : node.neighbours)
    {
        DFS(i);
    }
}
```

The method above is a **pure implementation of DFS**. In reality, this version of Depth first search is poor, since we can end up with problems in one of two ways:

- We end up in a cycle
- We are unable to print out the traversed node

---


## Process (Typical DFS)

A better solution is to have a **visited** list that we can use to check if a certain node can be visited or not, and only traverse to nodes that have not been visited. We can either use a *basic array* in which all the elements are nodes that **have been visited** thus far, or a hash map of all the values with the node as the key, and a *boolean* as for the value. Both methods are viable, however a hash map would give us much better performance with a time complexity of **O(1)** whilst the array based method requires searching and can only yield us a time complexity of **O(N)**, where *N* is the length of the array.

```clike
//C++ pseudo-demonstration
void DFS(Node node, unordered_map<Node,bool> visited)
{
    visited[node] = true;
    for(auto i : node.neighbours)
    {
        if(visited[i] == false)
            DFS(i);
    }
}
```

------

## Time Complexity

> DFS has a time complexity of **O(V+E)**, where **V** is the number of *nodes (vertices)*, and **E** is the number of *connections (edges)*. Here is an explanation on how this works:

In a worst case scenario, we would have a **"complete graph"**, one in which every node is connected to every other node. Sort of like a pentagram! Each node goes through each of its neighbours through the edges. This can be shortened to:

> **O( V<sub>0</sub> + All of V<sub>0</sub>'s edges + V<sub>1</sub> + All of V<sub>1</sub>'s edged [...] )**

which can be simplified to:

> **O( (V<sub>0</sub> + V<sub>1</sub> + [...] ) + ( E<sub>0</sub> + E<sub>1</sub> + [...]) )**

since each edge only gets visited once throughout the algorithm! A graph, by definition, is a pairwise data structure, so two nodes can't have the same edge going off of it. We can finally simplify this to:

> **O( All vertices + All edges )** or **O(V+E)**

------

## The Simulation

Here is a simulation, *written in [Godot](godotengine.org)*, that goes through the different algorithms for **DFS** discussed in this chapter. You can insert/delete nodes, add edges, and move around. Here is a quick tutorial on how to use it:

- Move around by dragging your mouse
- Double click to create a node, or destroy one. 
- Right click on a node to create an edge from it, right click on another node afterwards. (**Do not do this whilst the simulation is running!**)
- press escape while holding an edge to cancel that action
- change the speed of the simulation with the slider
- switch between pure and regular DFS with the switch button (**Do not do this whilst the simulation is running!**)
- **If the program crashes, please report it!!!** 

<iframe src="https://itch.io/embed-upload/3332544?color=333333" allowfullscreen="" width="1024" height="620" frameborder="0"><a href="https://ron0studios.itch.io/simple-graph-simulation">Play simple-graph-simulation on itch.io</a></iframe>

**CURRENTLY KNOWN ERRORS**

- adding an edge while the algorithm is running will lead to a crash, when it meets that edge. Will not be fixed by me, but if anyone pull-requests the solution, I shall happily oblige.

**if you have a solution to any of these please propose on the github!**
