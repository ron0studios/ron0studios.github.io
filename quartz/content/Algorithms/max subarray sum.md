# max subarray sum
---
>[!summary] An important [[prefix sum]] algorithm


# Explanation
---
Sometimes its necessary to find the *largest* sum between any two points in a [[range query]]. 
The algorithm to compute this, is known as the **max subarray sum**. Here is the algorithm:
> [!tldr] explanation
>- First compute a [[prefix sum]] on a target array.  
> 	- Iterate through each value $i$ in the prefix sum.
> 	- For each value $i$ find a value $j$ such that $j \leq i$ and $min(j)$. This is the max subarray sum with a right bound of $i$. Store the sum.
> 	- Your answer should then be the largest sum out of all possible $i$'s. 

For example, consider the array: 
$$
[ -1, 3, -2, 5, 3, -5, 2, 2]
$$
and its corresponding prefix sum:
$$
[-1,2,0,5,8,3,5,7]
$$
Now if if $i$ was equal to 2^[0-indexing], then $min(j)$ would be index 0. since $-1<2<0$. meaning that the max subarray sum bounded by index 2, would be index 0. 

If we finished the algorithm we would find that the answer would be $9$, with the left and right bounds being index 1 and 4 respectively, since $prefix[4]-prefix[1-1]=8--1=9$.



# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<ll> prefix(n+1,0); // +1 to include 0 at the beginning
	for(int i = 1; i <= n; i++)
	{
		cin >> prefix[i];
		prefix[i] += prefix[i-1];
	}

	ll max_sum = prefix[1];
	ll min_idx = prefix[0];
	
	// greedily finds the max value at each index
	for(int i = 1; i <= n; i++)
	{
		max_sum = max(max_sum,prefix[i]-min_idx);
		min_idx = min(min_idx,prefix[i]);
	}

	cout << max_sum << "\n";
}
```

