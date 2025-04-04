# bidirectional BFS
---
> A twist on a regular [[BFS]] algorithm, where instead of traversing a [[graph]] from a single source, you traverse from two sources two find the minimum distance between them

This requires two [[queue|queues]] in order to compute.

You essentially run a loop to go *layer by layer* in the search [[tree]]. and then check whether something has been visited in both layers


> [!error] # BIG WARNING
>**ALWAYS** break out of a layer by *checking* the front of the queue instead of popping it!!!
>For example, you should do this:
>>[!success] good code
>```cpp
> 	if(q1.front().second != dist1)
> 	{
> 		dist1++;
> 		break;
> 	}
> 	pair<int,int> node = q1.front(); q1.pop();
>```
># AND NOT THIS
>> [!failure] bad code
>```cpp
> 	pair<int,int> node = q1.front(); q1.pop();
> 	if(node.second != dist1)
> 	{
> 		dist1++;
> 		break;
> 	}
>```
