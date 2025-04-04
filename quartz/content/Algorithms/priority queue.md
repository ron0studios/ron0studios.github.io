# priority queue
>
A priority queue is a [[heap]] data structure, with the smallest value (i.e the highest priority) being at the top of the heap. It has two main operations: push() and pop(), which involve the appending and removal of nodes in the queue, respectively. 

It functions precisely like a [[queue]], except with the added *value* property of each element, where certain elements are put further up the queue, even though they entered later. Processing times for this algorithm can be slow, with **O(N)** linear updates, deletes and lookups, consider using an [[indexed priority queue]].

When popping from a priority queue, since each item is of the highest priority possible in the queue, we end up getting a [[sorting|sorted]] array, with each pop operation occuring in logN time, meaning you can technically sort an array in **O(NlogN)** time!

[here](obsidian://open?vault=Algo)
## D-ary priority queues
As a default, priority queues act like binary trees, having at most 2 children per node. With a D-ary priority queue, we can modify the number of children per node by D. This is an especially useful optimization depending on your data. Increasing D will result in more costly removals from the queue, but faster node updates. Again, especially useful for Dijkstra.


