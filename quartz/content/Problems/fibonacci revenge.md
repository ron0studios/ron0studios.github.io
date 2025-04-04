#bio
# fibonacci revenge
---
>[!summary] EASY  bio 2000 final problem


# Explanation
---
*none needed, just check [[dynamic programming]], or [[Fibonacci letters]]*

# Code
---
```cpp
void solve(int tc)
{
	string a,b; cin >> a >> b;
	ll n; cin >> n;

	vector<string> dp = {a,b};

	while(true)
	{
		dp.pb(dp.back() + dp[dp.size()-2]);
		if(dp.back().length() >= n) break;
	}
	cout << dp.back()[n] << "\n";
}
```