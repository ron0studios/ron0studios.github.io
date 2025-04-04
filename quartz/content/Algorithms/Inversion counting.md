---
aliases:
  - inversion index
---
# Inversion counting
---
>[!summary] A technique of counting the number of swaps needed to sort an array.^[not to be confused with [[sorting]] an array] It may be useful in a number of scenarios, but is mostly common in programming problems. The result of the algorithm will also be the number of steps needed to [[Bubble Sort]] an array. 
## Naive solution ($\pmb{\mathcal{O}(N^2)}$) 
The simplest, but slowest, solution would be to just perform the [[Bubble Sort]] algorithm on the array, and count the number of swaps made. This will follow the same time complexity as *bubble sort*, which will be $\pmb{\mathcal{O}(N^2)}$

## Optimal solution ($\pmb{\mathcal{O}(N\log{N})}$)
The optimal solution would be to perform something similar to [[merge sort]] on the array, exactly the same as the original algorithm up to the **merge** portion, where on top of merging the actual elements, we will increment our total number of *inversions* every time an element is selected from the *right* sublist instead of the left. 
For example if we have `{3, 2, 1, 4}`. Merge sort will split this into sublist `{3, 2}` and `{1, 4}`. The left sublist will cause one inversion as we have to swap 3 and 2 to get `{2, 3}`. The right sublist `{1, 4}` will not cause any inversion as it is already sorted. Now, we merge `{2, 3}` with `{1, 4}`. The first number to be taken is 1 from the front of the right sublist. We have two more inversions because the left sublist has two members: `{2, 3}` that both have to be swapped with 1 (see Figure 2.2). There is no more inversion after this.Therefore, there are a total of **3 inversions**.

This algorithm will run in the same pace as [[merge sort]], therefore at $\pmb{\mathcal{O}(N\log{N})}$. 