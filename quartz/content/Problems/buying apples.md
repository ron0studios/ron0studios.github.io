# buying apples
---
>[!summary] SPOJ problem
> relatively easy problem, but written porrly for 2 reasons:
> - It was never specified whether the packets are bounded or infinite
> - *N* is actually useless and the program can AC without considering it


# Explanation
---
This is an example of [[the knapsack problem|the unbounded knapsack problem]], and is closely related to [[unbounded knapsack]]

It uses typical knapsack rules, with the exception being that the [[dynamic programming|dp]] [[matrix|grid]] has to have its row duplicated if an item doesn't exist. 

# Code
---
```cpp
void solve(int tc)
{
	int n, k; cin >> n >> k;
	vector<int> packets(k+1,0);
	for(int i = 1; i <= k; i++)
	{
		cin >> packets[i];
	}

	vector<vector<int>> dp(k+1, vector<int>(k+1,INF));
	for(int i = 0; i <= k; i++)
		dp[i][0] = 0;

	for(int i = 1; i <= k; i++)
	{
		if(packets[i]==-1)
		{
			dp[i] = dp[i-1]; continue;
		}
		for(int j = 1; j <= k; j++)
		{
			int w = INF, wo; // with, without
			wo = dp[i-1][j];
			if(j >= i)
				w = dp[i][j-i] + packets[i];
			dp[i][j] = min(w,wo);
		}
	}
	
	int out = dp[k][k];
	if(out == INF)
		cout << -1 << "\n";
	else
		cout << out << "\n";
}
```