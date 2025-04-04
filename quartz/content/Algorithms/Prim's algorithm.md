# Prim's algorithm
>
prim's algorithm is a [[greedy]], [[Dijkstra]] like approach to creating a [[Minimum Spanning Tree]] in a [[graph]].

Unlike [[Dijkstra]], Prim's algorithm prioritizes the smallest edge weight that connects to an unvisited node (dijkstra prioritizes the **node** that has the least distance from the starting vertex ). 
Prim's algorithm begins by taking any starting node from the graph, marking it as visited (_in a [[hash map]]_). For each of this node's outgoing edges, we push these into a [[priority queue|min priority queue]]. 
From this point onwards, we enter the main stage of the algorithm. While the priority queue still contains elements (_meaning that there exists an edge that hasn't been accessed_), we do the following:

- We pop the top of the priority queue, saving it as a variable. We can skip this iteration if the outgoing vertex from this edge is already visited. 
- Otherwise, we mark the outgoing vertex as visited and append all of its edges to the priority queue, unless that edge leads into an already visited node.

This algorithm, in practice, due to the priority queue, intermittedly does the sorting section of [[Kruskal's algorithm]] while adding new edges. Both algorithms are efficient, but Prim's algorithm can actually be more effecient on dense graphs if we use an Indexed priority queue.

```ad-warning

Prim's algorithm is inefficient when trying to create a [[Minimum Spanning Tree#Minimum Spanning Forest|Minimum Spanning Forest]] since we would have to, not only find out different components in the graph, but then apply prim's for each and every component. Use [[Kruskal's algorithm]] in this case

```


## Speeding up prims
Prim's time complexity with a regular priority queue is **O(ElogE)** ^[note that asymptotically, this is still an **O(ElogV)**, but it is still multitudes slower], which can be slow for dense or complete graphs. A better solution, using an [[indexed priority queue]] can improve this to **O(ElogV)**. Watch this video for clarification:
<iframe width="560" height="315" src="https://www.youtube.com/embed/xq3ABa-px_g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Essentially, instead of E edges, we have V node-dge pairs that describe the MST. Instead of inserting *stale* edges that lead to alreadt visited nodes, we update the IPQ value of the outgoing node's incoming edge to a better edge. 