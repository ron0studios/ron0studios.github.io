# knapsack 1
---
>[!summary] Atcoder problem


# Explanation
---
its just [[dynamic programming]] [[the knapsack problem]]

> [!warning]
> Uninitialized variable usage **sucks**. It takes whatever was last in that memory slot, meaning it could have been the value of `without` or an index, meaning it can be pretty hard to trace!

# Code
---
```cpp
void solve()
{
	ll n, w; cin >> n >> w;
	vector<ll> weights(n,0);
	vector<ll> values(n,0);
	for(int i = 0; i < n; i++)
	{
		cin >> weights[i] >> values[i];
	}
	vector<vector<ll>> dp(n+1,vector<ll>(w+1,0));
	
	for(int i = 1; i <= n; i++)
	{
		for(int j = 1; j <= w; j++)
		{
			ll with = 0;
			ll without = dp[i-1][j];
			if(j >= weights[i-1])
			{
				with = dp[i-1][j-weights[i-1]] + values[i-1];
			}
			dp[i][j] = max(with, without);
		}
	}
	cout << dp.back().back();
}
```

**UPDATE 02/04/2023**
here's a recursive solution

```cpp
// recursive version of the same problem
vector<vector<ll>> recdp; // recursive dp
vector<ll> recvalues;
vector<ll> recweights;
ll compute(int n, int w)
{
	if(n<0 or w<0) return LLONG_MIN;
	if(n==0 or w==0) return 0;
	
	//cout << n << " " <<  w << endl;
	if(recdp[n][w] != 0) return recdp[n][w];
	return recdp[n][w] = max(compute(n-1,w), compute(n-1,w-recweights[n-1])+recvalues[n-1]);
}
```
