# binomial coefficients kind of
---
>[!summary] Codeforces educational round 170 B. 


# Explanation
---
A [[maths]] and simple [[dynamic programming|DP]] problem
# Code
---
```cpp

void solve()
{
	int t; cin >> t;
	vector<int> n(t);
	vector<int> k(t);

	for(int i = 0; i < t; i++)
		cin >> n[i];
	for(int i = 0; i < t; i++)
		cin >> k[i];

	vector<ll> dp(100007, 0);
	dp[0] = 1;
	for(int i = 1; i < 100007; i++){
		dp[i] = dp[i-1]*2;
		dp[i] %= MOD;
	}
	// combinations formula n!/r!(n-r)!

	for(int i = 0; i < t; i++){
		cout << dp[k[i]] << endl;
	}
	

}


```