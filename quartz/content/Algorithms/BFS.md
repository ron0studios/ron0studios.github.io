# Breadth First Search
>
breadth first search is a graph traversal algorithm that utilizes a [[queue]] data structure to create a layer by layer print of the graph, essentially forming a [[tree]]. This algorithm, therefore, can also find the shortest path to any node in a graph, given that all weights are the same or 1. 


Breadth first search operates similar to [[Dijkstra]], in that it runs a loop while the queue contains > 0 nodes and has a visited [[hash map]]. The algorithm begins by appending the base case, the starting node, to the queue and marking it as visited to the hashmap. Finding the neighbouring nodes from a certian node requires the [[graph#Node list| Node list]] representation of a graph.

## Creating a tree
One interesting property of BFS is that it can be used to form a tree data structure with each  layer of the tree representing the distance that node is from the starting vertex. 
A simple method of achieving this is by having all nodes saved in a hashmap and updating the values. 

Firstly, maintain the distance hashmap for all nodes 1 to N, defaulting all distances to 0. When BFS finds a new, unvisited, node and pushes it to the queue, we can update the value of that node in the hashmap to be the value of the current node + 1.

```ad-warning
collapse: open
BFS is ineffective at finding the shortest path when using a weighted graph!!!
```

A tree can then be formed in a similar way, where connections can be incited during the discovery of new unvisited nodes.