# LCS
---
>[!summary] Atcoder problem


# Explanation
---
see [[Longest common subsequence]] for the [[dynamic programming]] solution

# Code
---
```cpp

void solve()
{
	string s, t; cin >> s >> t; 
	int n, m; 
	n = s.length();
	m = t.length();

	vector<vector<int>> dp(n+1,vector<int>(m+1,0));
	for(int i = 1; i <= n; i++)
	{
		for(int j = 1; j <= m; j++)
		{
			if(s[i-1] == t[j-1])
			{
				dp[i][j] = dp[i-1][j-1]+1;
			}
			else
			{
				dp[i][j] = max(dp[i-1][j],dp[i][j-1]);
			}
		}
	}

	string out = " ";
	int i = n;
	int j = m;
	while(i > 0 and j > 0)
	{
		if(s[i-1] == t[j-1])
		{
			out = s[i-1] + out;
			i--; j--;
		}
		else
		{
			if(dp[i-1][j] > dp[i][j-1])
			{
				i--;
			}
			else
			{
				j--;
			}
		}
	}
	cout << out << endl;
}
```