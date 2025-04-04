# Atcoder candies
---
>[!summary] Hard [[dynamic programming|DP]] [[combinatorics]] problem


# Explanation
---
This is literally just [[the knapsack problem]] but there are a couple issues. 
- Instead of a value representing a singular candy, it represents a range of possible candies from 0 to N, meaning you have to sum all values in that range in the DP grid. 
- The answers can get very big, meaning modulo operations are required, especially with negative numbers, which c++ mod doesn't support well

To solve this, you need to manually implement modulus instead of using (%). You also need to use [[prefix sum|prefix sums]] for each row of the DP array instead of just values.

This brings a previously $\pmb{\mathcal{O}(N^{3})}$ to a much faster $\pmb{\mathcal{O}(N^{2})}$ solution. 

# Code
---
```cpp
void solve()
{
	int n, k; cin >> n >> k;
	vector<vector<ll>> dp(n+1,vector<ll>(k+1,1));
	
	for(int i = 1; i <= n; i++)
	{
		int candy; cin >> candy;
		for(int j = 1; j <= k; j++)
		{
			int left = j-candy-1;
			int right = j;
			dp[i][j] = dp[i][j-1];
			if(left < 0)
			{
				dp[i][j] += dp[i-1][right];
				if(dp[i][j] >= MOD)
					dp[i][j] -= MOD;
			}
			else
			{
				ll toadd = dp[i-1][right] - dp[i-1][left];
				if(toadd < 0)
					toadd += MOD;
				dp[i][j] += toadd;
				if(dp[i][j] >= MOD)
					dp[i][j] -= MOD;
			}
		}
	}

	ll left = 0; ll right = 0;
	right = dp[n][k];
	if(k > 0) left = dp[n][k-1];
	ll diff = right - left;
	if(diff < 0) diff += MOD;
	cout << diff;
}
```