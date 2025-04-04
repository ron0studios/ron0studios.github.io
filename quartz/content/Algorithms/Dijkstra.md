# Dijkstra shortest path algorithm

>
 a [[greedy]] shortest path [[graph]] algorithm.


```ad-warning
 *only works with non-negative edge weights*
```
- Input the graph as a [[graph#Node list|Node list.]]
- create a [[priority queue]] (indexed if possible)
- create a [[hash map]] of the distances and whether a node has been visited
- before entering the main loop. Add your starting node to the priority queue, mark it as visited, and make sure to set its distance to 0. 
- **while** the priority queue contains atleast 1 item (i.e its not empty):
	- remove the front of the queue. save it as a variable.
	- mark the node as visited
	- at this point, you can make an optimization. if the distance already given to the node in the hashmap is less than the distance of the node itself to from wherever it came from, i.e its leading edge, then you can skip this iteration, since the node has already reached an optimal state, and it means that a better route must have already been found in the past. **This optimization is crucial if you aren't using an [[indexed priority queue|_indexed_ priority queue]], because you will tend to find many copies of the same node in the queue, meaning the same node will be done many times over if this optimization is not made**. 
	- for each edge leading out the node:
		- skip if already visited
		- if the distance of the current node + the weight of the edge to the second node is less than the distance of that node on the hashmap- adjust the hashmap with the smaller distance and push the second node into the queue.
		
	here is a useful video, with the timestamp of the pseudocode:
		
	<iframe width="560" height="315" src="https://www.youtube.com/embed/pSqmAO-m7Lk?start=696" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	
	## Speed
	in dijkstra without the indexing, the size of the heap can reach up to **E**, meaning that the time complexity is **O(ElogE)**^[This, asymptotically, is commonly still rounded to O(ElogV), since E is the same as V^2, but this inclusion can help drastically improve performance.], which is slow for dense or complete graphs, using an [[indexed priority queue]] can speed this up to **O(ElogV)**.