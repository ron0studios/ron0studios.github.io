#bio
# seed
---
>[!summary] Pretty easy BIO R2 2013 question


# Explanation
---
This is the exact same problem as [[coin-combinations II]].  
> [!note]
> Note how the question *specifically* says that **the order of the packets does not matter**

# Code
---
```cpp
void solve(int tc)
{
	int n, p; cin >> n >> p;
	vector<int> seeds(p);
	for(int i = 0; i < p; i++)
		cin >> seeds[i];

	vector<vector<ll>> dp(p+1,vector<ll>(n+1));

	for(int i = 0; i <= p; i++)
		dp[i][0] = 1;

	for(int i = 1; i <= p; i++)
	{i
		for(int j = 1; j <= n; j++)
		{
			int seed = seeds[i-1];
			if(j-seed < 0){
				dp[i][j] = dp[i-1][j];
				continue;
			}

			dp[i][j] += dp[i][j-seed] + dp[i-1][j];
		}
	}

	cout << dp.back().back() << endl;
}
```