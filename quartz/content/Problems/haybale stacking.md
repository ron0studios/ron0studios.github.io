# haybale stacking
---
> [!note] An interesting problem from USACO 2012 (old bronze) Q2

# Explanation
---
This problem requires [[prefix sum|prefix sums]], *but not in the way you might think*. 

A naive solution would be to increment all values in the range of the query, however, this would be slow, and could have a time complexity of $O(N^2)$, which is atrocious, considering $N$ can be up to $1,000,000$. 

A better solution is to make a prefix array of size $N$. and for each query $\{A,B\}$, we will increment $prefix[A]$ and decrement $prefix[B+1]$, meaning that at the beginning of the query all numbers will be incremented, up till $B$, after which the prefix is decremented. 

This is what I call, doing an [[inverse prefix sum]]

Consider the example $N = 7$, $K = 4$, and the following $K$ queries:

```
5 5
2 4
4 6
3 5
```

Here is the resulting prefix array being built, per operation:


| A   | B               |
| --- | --------------- |
| 5 5 | 0 0 0 0 1 -1 0  |
| 2 4 | 0 1 0 0 0 -1 0  |
| 4 6 | 0 1 0 1 0 -1 -1 |
| 3 5 | 0 1 1 1 0 -2 -1 |

And now, all we have to do is to fill in our $N$ sized regular array for the stacks using the following algorithm

```cpp
Array stacks(n,0);
stacks[0] = prefix[0];
for(int i = 1; i < n; i++)
{
	stacks[i] = stacks[i-1] + prefix[i];
}
```

Using the previous example, this would result in the following array:
$$
[0,1,2,3,3,1,0]
$$

And now, all we have to do is sort it using STL, which takes $O(NlogN)$, and find the median value!


# Code
---
```cpp
void solve()
{
	int n, k; cin >> n >> k;
	vector<pair<int,int>> queries(k,mp(0,0));
	for(int i = 0; i < k; i++)
		cin >> queries[i].first >> queries[i].second;
	
	vector<int> prefix(n,0);

	// process queries
	for(auto query : queries)
	{
		// convert to 0-indexing
		prefix[query.first-1]++;
		if(query.second	!= n)
			prefix[query.second]--;

		for(auto i : prefix)
			cout << i << " ";
		cout << endl;
	}

	// convert to regular array
	vector<int> stacks(n,0);
	stacks[0] = prefix[0];
	for(int i = 1; i < n; i++)
	{
		stacks[i] = stacks[i-1] + prefix[i];
	}


	sort(stacks.begin(), stacks.end());

	cout << stacks[ floor(n/2) ];
}

```