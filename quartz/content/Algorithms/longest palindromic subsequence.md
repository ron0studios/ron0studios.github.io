# longest palindromic subsequence
---
>[!summary] What is the longest **subsequence** in a string that is also a palindrome?


# Explanation
---
This is a very neat problem, since its solution is based entirely on the [[Longest common subsequence]] problem.

Essentially, you use the same [[dynamic programming|DP]] structure, but instead of comparing between two different strings, you compare between the original string and the reversed version of the original string. *the longest common subsequence in both strings must be a palindrome!*

# Code
---
```cpp

void solve(int tc)
{
	string A; cin >> A;

	string B = string(A.rbegin(), A.rend());
	vector<vector<int>> dp(A.length()+1, vector<int>(A.length()+1,0));

	for(int i = 1; i <= A.length(); i++)
	{
		for(int j = 1; j <= A.length(); j++)
		{
			if(A[i-1] == B[j-1])
			{
				dp[i][j] = dp[i-1][j-1]+1;
				continue;
			}
			dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
		}
	}

	cout << dp.back().back() << endl; 


}


```