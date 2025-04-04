# Kruskal's algorithm 
>
Kruskal's algorithm is a [[Minimum Spanning Tree]] algorithm that generates an MST based on a [[greedy]] approach. Unlike [[Prim's algorithm]], Kruskal's simply requires a sorted list of edges from a graph, performing at similar speeds to Prim's. 

## method
Kruskal's algorithm works best off of an [[graph#Edge list|edge list representation]] of a graph. We, firstly sort all the edges given by their weight, from smallest to biggest. 


> [!warning]
The sorting algorithm used is extremely important to the time complexity of this algorithm. 


Once completed, we then, for each of the edges, check if that edge joins together **two different components** in the graph, given that the graph starts off with no edges at all. After iterating through all the edges, we should find ourselves a set of edges that determine the MST. 
The way in which we determine whether an edge joins two different components is very crucial to the performance of this algorithm. An effective structure for this would be the union-find structure, shown below.

![[Union-find structure]]

We initialize the link and size variables, firstly, as follows:

```c++
// where V is equal to the number of nodes
// assuming that all nodes are numbered 0-V
for(int i = 0; i < V; i++) link[i] = i;
for(int i = 0; i < V; i++) size[i] = 1; 
```
This essentially creates an empty graph with no connecting edges, and *V* components. All nodes are linked to itself, being representative, and the size of each node is 1.

The algorithm then proceeds by looping through each edge in the sorted array, and uniting the two components if the two nodes are in separate components:
```c++
for( edge )
{
	if(find(edge.from) != find(edge.to)) unite(edge.from, edge.to);
}
```

You can also append the resultant edge to a separate array. After this, you will have your chosen edges in the [[Minimum Spanning Tree]]!

The time complexity of this algorithm is **O(E logV)**, if a decent sorting algorithm is used. Since **O(NlogN)** sorting is prebuilt into most languages, Kruskal's algorithm is by far the easiest MST algorithm to implement