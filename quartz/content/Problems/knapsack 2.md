# knapsack 2
---
>[!summary] Twisty atcoder problem


# Explanation
---
This is a twist on the classic [[dynamic programming|DP]] problem, [[the knapsack problem]], where the knapsack bag can be massive. 

We can solve this by inverting the DP array as shown [[the knapsack problem#When pmb 1 leq W leq 1000000000 big|here]]

# Code
---
```cpp

void solve()
{
	int n, w; cin >> n >> w;
	vector<int> weights(n,0);
	vector<int> values(n,0);
	
	ll mxval = 0;
	for(int i = 0; i < n; i++)
	{
		cin >> weights[i] >> values[i];
		mxval += values[i];
	}
	
	vector<vector<ll>> dp(n+1, vector<ll>(mxval+1, 1e15)); 
	for(int i = 0; i <= n; i++)
		dp[i][0] = 0;
		
	for(int i = 1; i <= n; i++)
	{
		for(int j = 1; j <= mxval; j++)
		{
			ll with = 1e15;
			ll without = dp[i-1][j];
			if( j >= values[i-1]) 
				with = dp[i-1][j- values[i-1]] + weights[i-1];
			dp[i][j] = min(with,without);
		}
	}
	// scan
	int outidx = -1; 
	for(int i = mxval; i >= 0; i--)
	{
		if(dp[n][i] <= w) 
		{
			outidx = i; break;
		}
	}
	cout << outidx << endl;
}
```