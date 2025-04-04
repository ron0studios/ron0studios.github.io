# Fenwick Tree
---
>[!summary] An efficient data structure for making [[range query|range queries]] in $\pmb{\mathcal{O}(logN)}$ time


# Explanation
---

The Fenwick tree operates on a single array, and uses powers of 2 to find the sum up to any index at that point. ]

For an array $tree$, let $$tree[k]=\text{sum}_{q}(k-p(k),k)$$
where $p(k)$ is the largest power of 2 that divides $k$. The length of $tree$ is the same as the length of the array on which you're basing the Fenwick tree on.

So, for example, if you had an array: $$[1_1,3_2,4_3,8_4,6_5,1_6,4_7,2_8]$$
The corresponding Fenwick tree to this array would be: $$[1_1,4_2,4_3,16_4,6_5,7_6,4_7,29_8]$$
Here's what that array looks like if you were to show what subarray of the original is being added. 
![[image-20230729192752130.png]]

## finding the sum

Given the structure above, in order to find the sum from index 1 to some index $k$, you would have to sub
