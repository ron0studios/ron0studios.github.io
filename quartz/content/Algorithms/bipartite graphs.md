# bipartite graphs
---
>[!summary] A [[graph]] which can be separated into 2 groups of node, where each node has no internal links
>
![[image-20231105122152433.png]]


# Detection
---
use [[BFS]]. Color each alternate layer with a different number. If at any point, the current node neighbours a node of the same colour, you know the graph cannot be made bipartite.
if the BFS completes successfully you know **the graph component** is bipartite.

> [!warning]
> note that if you have a **forest** type graph, i.e. a graph with many different components, the BFS method will **NOT** check the bipartite-ness of the other components.
> Perhaps consider running a loop through all nodes, or, for more efficiency, using a [[Union-find structure]].

