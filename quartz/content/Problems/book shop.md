# book shop
---
>[!summary] Generous cses problem


# Explanation
---
This is a [[the knapsack problem]] question, but bounded. Usually you would stay in the same row of the [[dynamic programming|DP]] matrix , but this time you go up a row.

# Code
---
```cpp
void solve()
{
	int n, x; cin >> n >> x;
	vector<int> price(n,0);
	vector<int> pages(n,0);
	for(int i = 0; i < n; i++)
		cin >> price[i]; // price is weight
	for(int i = 0; i < n; i++)
		cin >> pages[i]; // pages is value

	vector<vector<int>> dp(n+1,vector<int>(x+1,0));
	for(int i = 1; i <= n; i++)
	{
		for(int j = 1; j <= x; j++)
		{
			int with,without;
			without = dp[i-1][j];
			with = -1;
			if(j >= price[i-1])
			{
				with = dp[i-1][j-price[i-1]] + pages[i-1];
			}
			dp[i][j] = max(with,without);
		}
	}
	cout << dp.back().back();
}
```