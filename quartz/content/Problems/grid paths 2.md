# grid paths 2 (DP)
---
>[!summary] 
>CSES grid paths question from the DP category


# Explanation
---
This is a classic [[dynamic programming]] problem where you add both the path from the square above and the square to the left, setting the starting square to 1 in the dp [[matrix|grid]]. 

However, since there are traps, you have to skip calculating DP for those trap.
Also, if the starting square has a trap, immediately return 0

# Code
---
```cpp

void solve()
{
	int n; cin >> n;
	vector<vector<bool>> grid(n,vector<bool>(n,false));
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
		{
			char x; cin >> x;
			if(x=='*') grid[i][j] = true;
		}
	}
	if(grid[0][0])
	{
		cout << 0;
		return;
	}

	vector<vector<int>> dp(n+1,vector<int>(n+1,0));
	dp[1][1] = 1;
	for(int i = 1; i <= n; i++)
	{
		for(int j = 1; j <= n; j++)
		{
			if(i==1 and j==1) continue;
			int top = dp[i-1][j];
			int left = dp[i][j-1];
			if(grid[i-1][j-1] == true)
				continue;
			dp[i][j] = top + left;
			dp[i][j] %= MOD;
		}
	}

	cout << dp[n][n];
}


```