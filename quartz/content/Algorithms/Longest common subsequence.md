# Longest common subsequence
---
>[!summary] 
>An essential algorithm that requires [[dynamic programming]]


This algorithm operates similarly to other string based DP, such as [[edit distance]]. You create a [[matrix|grid]] of $N$ rows and $M$ columns, where $N$ and $M$ are the sizes of the two strings. 

## DP definition
---
`dp[i][j]` representing the solution to a subproblem where `i` is the substring of the first string up to index `i` and `j` is the substring of the second string up to index `j`. 
This state represents the length of the longest commons subsequence at these indices.

## base case
---
The base case is if either of the two strings are empty, in which `dp[i][j] = 0`

## Transitions
---
If `a[i] != b[i]`^[in your actual code the indices may be shifted to account for 1-indexing]:
$$
dp[i][j] = max \begin{cases} dp[i-1][j], \\
dp[i][j-1]\end{cases}
$$
If `a[i]==b[i]`^[same as the other footer]:
$$
dp[i][j] = dp[i-1][j-1]+1
$$



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
				dp[i][j] = dp[i-1][j-1]+1;
			else
				dp[i][j] = max(dp[i-1][j],dp[i][j-1]);
		}
	}

	string out = " ";
	int i = n;
	int j = m;
	// retrieving the subsequence
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
				i--;
			else
				j--;
		}
	}

	cout << out << endl;
}
```

## Code (recursive)
---
```cpp

string s,t;
vector<vector<int>> dp;

int LCS(int i, int j)
{
	if(i==0 or j==0) return 0;
	if(dp[i][j] != -1){
		return dp[i][j];
	}

	if(s[i-1] == t[j-1])
		return dp[i][j] = 1+LCS(i-1,j-1);


	return dp[i][j] = max(LCS(i-1,j), LCS(i,j-1));
}

void solve()
{
	cin >> s >> t;
	dp = vector<vector<int>> (s.length()+1, vector<int>(t.length()+1, -1));
	LCS(s.length(), t.length());
	string out = "";

	int i = s.length(); int j = t.length();
	while(i and j){
		if(s[i-1] == t[j-1]){
			out = s[i-1] + out;
			i--; j--;
		}
		else{
			if(dp[i-1][j] > dp[i][j-1])
				i--;
			else
				j--;
		}
	}
	cout << out;
}
```