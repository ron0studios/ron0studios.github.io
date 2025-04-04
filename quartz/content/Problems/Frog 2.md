# Frog 2
---
>[!summary] An easy Atcoder problem


# Explanation
---
This is similar to [[Frog 1]] except it now requires $K$ coins instead of just 2. It's still a simple [[Coin Change]] [[dynamic programming|DP]] problem, which I again used push DP on.

# Code
---
```cpp
void solve()
{
	int n, k; cin >> n >> k;
	vector<int> stones(n+k, 0);
	for(int i = 0; i < n; i++)
		cin >> stones[i];
		
	vector<int> dp(n+k, INF);
	dp[0] = 0;
	for(int i = 0; i < n; i++)
	{
		for(int j = 1; j <= k; j++)
		{
			dp[i+j] = min(dp[i+j], dp[i] + abs(stones[i+j] - stones[i]) );
		}
	}
	cout << dp[n-1];
}
```