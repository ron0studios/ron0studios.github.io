# Merge sort
---
#tofinish 
> A divide-and-conquer [[sorting]] algorithm with a fast time complexity of **O(nlogn)


# Explanation
---

![[Pasted image 20220218181945.png]]

the process of merge sort includes the recursive *mergesort* function, and then the linear *merge* function. In total there are log(n) mergesort() calls, since the height of a tree (at its worst) is logN, where N is the total number of nodes. Combining this with N merges, we get **nlogn**

> [!info] fun fact
> The *merge* function is literally just [[two pointers method]].

# Code
---