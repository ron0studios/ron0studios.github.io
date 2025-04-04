# removing digits
---
>[!summary] A dynamic programming problem from cses


# Explanation
---
This is closely related to the [[minimising-coins]] problem. 

Essentially, for each number you have $N$ choices you can make, where $N$ is the number of digits in that number. For the number $4$ you only have 1, which is to substract 4. For the number 1345, you have 4 options, which is to either take away 1, 3, 4, or 5.

You can make a dp array `dp[x]` where `x` represents the minimum operations required for the number `x`. 

A base case would be $dp[0]$, which is equal to 0. For all other values, set them to infinity. 

What this results to is the following DP formula.
$$
dp[x] = min \begin{cases}dp[x-\text{digit}_1] \\
dp[x-\text{digit}_2]\\
dp[x-\text{digit}_3] \\
dp[x-\text{digit}_4] \\
[...] \\
dp[x-\text{digit}_N]
\end{cases}
$$

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> dp(n+1, INF);
	dp[0] = 0;
	for(int i = 1; i <= n; i++)
	{
		for(auto j : to_string(i))
		{
			dp[i] = min(dp[i], dp[i-(j-'0')]+1);
		}
	}
	cout << dp.back();
}
```