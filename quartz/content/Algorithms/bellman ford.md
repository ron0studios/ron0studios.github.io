# Bellman-Ford shortest path algorithm
>
go through all of the edges of the graph, and search for reducing edge distances.
Keep doing this N times.

basically this means, firstly, creating a hash map like this:

| Node | Distance |
| ---- | -------- |
| A    | 0        |
| B    | ∞        |
| C    | ∞        |
| D    | ∞        |
| E    | ∞        |

And go through all the edges, via an [[graph#Edge list|Edge List]], check if the distance is less than `Map[Node]` and change it if it is. 
![[Bellman-Demo.excalidraw.png]]
You need to do this **N** times, where N is the number of nodes. Usually it already finds the shortest paths after the first 2 or 3, but doing it N times guarantees it. An example for this is in  [[Bellman-Demo.excalidraw.png]] where the edge list iterates from top to bottom. (A->B, A->C, B->D, C->D, D->E). However, if done the other way around, then the shortest path for, say, E would still be ∞. You would have to re-run the algorithm a few more times to get the shortest path for E.

If you want to check for negative cycles, run this algorithm twice, if there is a change in any distances after the 2nd run through, then it means it will keep going down forevever, therefore we can change the values for those particular nodes to just be -∞.

This algorithm is slower than [[Dijkstra]] but can work with negative weight values and negative cycles, which makes it superior for certain cases.