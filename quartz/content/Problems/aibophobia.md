# aibophobia
---
>[!summary] A SPOJ [[dynamic programming]] problem


# Explanation
---
You take the [[longest palindromic subsequence]] of the string. The number of leftover characters is the number you need to add to make the whole thing a palindrome

# Code
---
```cpp
//spoj
void solve(int tc)
{
	string s; cin >> s;
	string r = string(s.rbegin(), s.rend());
	int n = (int)s.length();

	vector<vector<int>> dp(n+1,vector<int>(n+1,0));

	for(int i = 1; i <= n; i++)
	{
		for(int j = 1; j <= n; j++)
		{
			if(s[i-1] == r[j-1])
			{
				dp[i][j] = dp[i-1][j-1] + 1;
			}
			else
			{
				dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
			}
		}
	}
	

	cout << n-dp[n][n] << "\n";
}
```