# ada and coins
---
>[!summary] A very strict [[dynamic programming]] problem from SPOJ


# Explanation
---
This is a harder version of [[the knapsack problem]], as it requires heavy optimization to pass all test cases. 

Unlike regular knapsack, you are asked to find out **how many** of the possible sums in a given range can be achieved^[rather than the typical  "is sum X reachable" or "minimum cost to reach sum X"]. 
You will be given multiple [[range query|range queries]], each asking for the number of reachable solutions in a range. 

### Optimization 1: prefix sums
 > Our first optimization involves finding a quicker way to calculate the number of possible sums reachable in a given range. 

Say we've already computed our DP for all knapsack items. All we have to do is to process the queries. Since there are potentially thousands of queries, each of which *could* span a large portion of the DP array, we potentially face having to deal with an $O(N^2)$ solution. *this is bad*. 

Instead we can bring this down to linear time (processing all queries), by computing a [[prefix sum]] of the DP array, including the number 0. 

We can now compute the sums. 

### Optimization 2: bitset dp
> Our code is still unbearably slow, running at 10-15 seconds in the worst-case scenario. We need to be able to hit under 1 second to avoid TLEs.  
> In order to optimize this further, we are going to speed up our solution 32$\times$ using [[bitset DP]]

Instead of looping through each row and checking `dp[i-1][j] | dp[i-1][j-W[i]]`, what we can do is work with only 1 DP array, and shift everything by `W[i]` for each item in the knapsack. 

This works for 2 reasons:
- we work through a regular 2D DP grid row by row, using only the previous row for calculations. We can just compress this, since once we're done with a row, we can reuse the row and override it with the new row, so we can use that row for the row afterwards, all on the same row! 
The only thing we have to change is how we process the array, which is to go from the end to the beginning, instead of vice versa, because we would end up overriding elements that may get used later in the loop. 

- Sure, we could do what I said in the last bullet point and run a **loop** for each element in the row backwards. However, this is still slow, the only optimization we would have made is space complexity. 
What we can do instead is, for each knapsack item, we apply an **OR** operation on the row to the current row bit shifted `W[i]` times to the right. This works because the only state transitions in this problem (in the new 1D version) is we check either the current bit is true or the current bit's index minus the weight of the item is true. If either of those are true, we can make or keep the current index's bit as true. This is the same thing as doing an **OR** operation^[note that this is entirely the same with the 2D version of DP, with the only difference in the DP optimization being that instead of checking the current row's current index, you check the above row's current index, and **OR** it with itself shifted to create the new row].

# Code
---
```cpp

void solve()
{
	int n, q; cin >> n >> q;
	vector<int> coins(n,0);
	for(int i = 0; i < n; i++){
		cin >> coins[i];
	}

	int mx = -1;
	vector<pair<int,int>> queries(q,mp(0,0));
	for(int i = 0; i < q; i++)
	{
		cin >> queries[i].first >> queries[i].second;
		mx = max(mx,queries[i].second);
	}

	bitset<100001> dp;
	dp[0] = 1;

	for(int i = 1; i <= n; i++)
	{
		dp |= (dp << coins[i-1]);
	}

	vector<ll> pref = {0};
	for(int i = 1; i <= mx; i++)
	{
		pref.pb(pref.back()+dp[i]);
	}
	
	for(auto k : queries)
	{
		ll out = 0;
		out = pref[min(k.second,mx)] - pref[min(k.first,mx)-1];
		cout << out << "\n";
	}
}
```

