# Frog 1
---
>[!summary] Easy Atcoder DP problem


# Explanation
---
This is simply a classic [[Coin Change]] problem
I tried expermenting with push [[dynamic programming|DP]] this time, its way easier!

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> stones(n+2,0);
	for(int i = 0; i < n; i++)
	{
		cin >> stones[i];
	}
	vector<int> dp(n+2,INF);
	dp[0] = 0;
	for(int i = 0; i < n; i++)
	{
		dp[i+1] = min(dp[i+1],dp[i] + abs(stones[i+1]-stones[i]) );
		dp[i+2] = min(dp[i+2],dp[i] + abs(stones[i+2]-stones[i]) );
	}

	cout << dp[n-1];
}
```