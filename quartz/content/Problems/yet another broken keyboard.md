# yet another broken keyboard
---
>[!summary] A neat CF problem


# Explanation
---
This is a relatively simple [[dynamic programming]] problem. 

Essentially if the keys are valid, then `dp[x]` is equal to `dp[x-1]+1`. If not, its just 0. You sum up the array to get your answer. The DP array is represented as follows:
> `dp[X]` where `X` represents a substring ending in index `X`

This is similar to the [[longest increasing subsequence]] layout.

# Code
---
```cpp

void solve()
{
	int n,k; cin >> n >> k;
	string s; cin >> s;
	unordered_map<char,bool> valid;

	for(int i = 0; i < k; i++)
	{
		char x; cin >> x;
		valid[x] = true;
	}

	vector<ll> dp(s.length()+1,0);

	long long out = 0;
	for(int i = 1; i <= s.length(); i++)
	{
		if(valid.count(s[i-1]))
		{
			dp[i] = dp[i-1]+1;
			out += dp[i];
		}
		else
		{
			dp[i] = 0;
		}
	}
	//cout << accumulate(dp.begin(),dp.end(),0);
	cout << out;
}


```