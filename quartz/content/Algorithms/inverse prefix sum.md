# inverse prefix sum
---
>[!summary] A way to quickly process multiple [[range query|range queries]] using a [[prefix sum]].
> Usually you have your data given and you create a prefix sum to process queries. In this case, you aren't given the data, and you have to run many queries, which is slow. 

## How it works
---
You create a prefix-array for all the **changes** between consecutive indices. This is exactly the same as [[haybale stacking]], check the problem here first:
![[haybale stacking]]


## 2D inverse prefix sum
Ok so this one is a bit harder, here's a way to explain it:

consider the definition of each element of a [[2D prefix sums|bounded 2D prefix sum]]. 
$$
A=prefix[x_2][y_2]-prefix[x_1-1][y_2]-prefix[x_2][y_1-1]+prefix[x_1-1][y_1-1]
$$
which looks like this:

| 1   | 0   | 0   | 0   | -1  |
| --- | --- | --- | --- | --- |
| 0   | 0   | 0   | 0   | 0   |
| 0   | 0   | 0   | 0   | 0   |
| 0   | 0   | 0   | 0   | 0   |
| -1  | 0   | 0   | 0   | 1   |

but if we were to *inverse* this ,then our *delta/difference* matrix would look like the above as well!, with the difference being that the top-left corner starts the bound of the box **inclusively** rather than exclusively. 

Think about it like this: 

> [!tip] intuition
> The top-left $1$ creates the box, with everything below and to the right of it (and diagonally down) is incremented
> 
> The bottom-left $-1$ prevents the bounds from infinitely extending down the first axis.
> 
> The top-right $-1$ prevents the bounds from infinitely extending down the second axis.
> 
> The bottom-right $1$ cancels out the section where the two $-1$s intersect to make it zero.

Therefore, instead of incrementing everything by hand, we simply create these 4 boundaries for each operation and then, in 1 loop through the grid fill in the values. 
See [[]]