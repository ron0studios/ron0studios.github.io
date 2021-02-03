# DFS

## Overview

**Depth First Search**, or **DFS**, is a *recursive, graph traversal algorithm*. It follows the principal of **backtracking** to find all nodes reachable from a given source. It is often seen as the *simplest graph traversal algorithm*, but can be used practically in nearly every graph question you find online. 

> **Quick tip:** on [Codeforces](www.codeforces.com), around 1/ 10 problems require you to use DFS in order to solve the problem, that's over 600!

## Process

As mentioned earlier, Depth First Search is a backtracking algorithm. We begin with the starting node **A**, which will act as our source. We then loop through all of the connections the nodes makes, and traverse to that node recursively. We keep following this path until we reach a node that *makes no connections*. We then backtrack automatically and continue the loop from the parenting node. With this method, we will have gone through all possible nodes that are reachable from **A**

Here is some C++ pseudocode to help demonstrate:

```c++
void DFS(vector<int> node) //node is represented as an array-vector of all its neighbouring nodes
{
    for(auto i : node)
    {
        DFS(i);
    }
}
```

The method above is a **pure implementation of DFS**. In reality, this version of Depth first search is poor, since we can end up with problems in one of two ways:

- We end up in a cycle
- We are unable to print out the traversed node

<iframe frameborder="0" src="https://itch.io/embed-upload/3305233?color=333333" allowfullscreen="" width="1024" height="600"><a href="https://ron0studios.itch.io/simple-graph-simulation">Play simple-graph-simulation on itch.io</a></iframe>
