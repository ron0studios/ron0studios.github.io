# prefix sum
---
> A way to compute [[range query| range sum queries]] in linear time 


# The problem
---
Usually, if you want to find the sum of values in an array, you would manually add up all values from index a to index b, which would take $O(n)$ in linear time and even worse $O(n^2)$ in the case that we have multiple range queries.

This is highly inefficient and will almost allways lead to a TLE.

# The prefix sum array
---
An optimal solution is to create an array that sums up these values. 
Formally, this would look like 
$$
prefix[k] = \sum_{i=1}^{k}arr[i].
$$
We use 1-indexing here, meaning we set $arr[0] = 0$. ^[we do this because if we need to use the *first* index of our prefix sum, then $i-1$ won't go out of bound, since it will point to 0]

## Usage
---
What we can now do is calculate any sum between indexes $L$ and $R$ in the array in constant time!^[$O(1)$]. Here's how it works:

In order to calculate the sum of all values in an array, inclusively between two indexes, lets say $L$ and $R$ ^[left and right], we can use our prefix array as follows: 
$$
\sum\limits_{i=L}^{R}arr[i] = prefix[R] - prefix[L-1]
$$
The reason we substract 1 from $L$ is so that we can include $L$ itself when calculating the sum. This is evident when you consider what each element of a prefix sum actually is:
$$
prefix[K] = prefix[K-1] + arr[K]
$$
When we substract $prefix[L-1]$ from $prefix[R]$ , what we're doing is taking away all of previous values that sums to make $L$ and substract that from the total of $R$, leaving behind the total of values between $L$ and $R$ inclusively. 

