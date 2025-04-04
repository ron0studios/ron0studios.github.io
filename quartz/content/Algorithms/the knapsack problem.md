# the knapsack problem
---
>[!summary] A fundamental [[dynamic programming]] algorithm 
>check [[unbounded knapsack]] and [[coin-combinations II]] for more explanatrions

## bounded
---
$$
dp[i][j] = \begin{cases} dp[i-1][j] \\ dp[i-1][j-c[i]] \end{cases}
$$
## unbounded
---
$$
dp[i][j] = \begin{cases} dp[i-1][j] \\ dp[i][j-c[i]] \end{cases}
$$
The difference is that for the case where you *do* use a coin, you don't go back a row, since that would mean being forced to branch to the path without that coin, in which you can't use it anymore

## Bitset optimisation
---
Using [[bitset DP]] you can speed up the processing time of most knapsack problems by 32 times! 
In order to do this you represent the DP grid as a set of bitsets^[or you could have a single DP bitset]. 
Once you do this the result of adding a new knapsack item (the next row) would just be the row before it left bit shifted by the value of the item. 

Consider the following bitset array from a previous row:

| 1   | 0   | 1   | 0   | 0   | 0   | 
| --- | --- | --- | --- | --- | --- |
Say now, in the current row, we include an item with the value of 2. This means, if you remember traditional knapsack, that we would loop through each cell and check that the following are
possible: 
- if either `[i-1][j]` is true or `[i-1][j-W[i]]` is true, we can set the current cell to true

Note now that this is the same thing as doing an **OR** operation on that bit with both the above row and the above row and a few indices back. 

This means we can simply bitshift our previous row to the right by 2 and apply an **OR** operation to both. 
This yields us:

| 1   | 0   | 1   | 0   | 1   | 0   |
| --- | --- | --- | --- | --- | --- |

> [!warning]  WARNING!!!!
> **remember that if you are using a c++ `bitset<X>`, then you have to left shift, not right shift, since bits are set from right to left instead of left to right!!**
>  i.e setting `bitset[0]`  to 1, does **not** set the leftmost bit to 1, but rather the rightmost (weakest) bit to 1. 


## When $\pmb{1 \leq W\leq 1000000000}$ (big)  
---
In this scenario, typical knapsack, which operates at $\pmb{\mathcal{O}(NW)}$, would not suffice. In this case, we can't have the weight as each column, instead we use the value. 

Essentially, this time `dp[i][j]` means the minimum weights required in the subproblem using the first `i` elements, where the value cannot exceed `j`. 