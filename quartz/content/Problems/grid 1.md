# grid 1
---
>[!summary] easy atcoder problem


# Explanation
---
same as [[grid paths 2]]

# Code
---
```cpp
void solve()
{
	int h,w; cin >> h >> w;
	vector<vector<char>> grid(h,vector<char>(w,0));
	for(int i = 0; i < h; i++)
	{
		for(int j = 0; j < w; j++)
		{
			cin >> grid[i][j];
		}
	}
	vector<vector<ll>> dp(h+1,vector<ll>(w+1,0));
	dp[0][0] = 1;
	for(int i = 0; i < h; i++)
	{
		for(int j = 0; j < w; j++)
		{
			if(grid[i][j] != '#')
			{
				dp[i+1][j] += dp[i][j];
				dp[i+1][j] %= MOD;
				dp[i][j+1] += dp[i][j];
				dp[i][j+1] %= MOD;
			}
		}
	}
	cout << dp[h-1][w-1];

}
```