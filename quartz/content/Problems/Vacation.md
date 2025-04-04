# Vacation
---
>[!summary] An interesting Atcoder [[dynamic programming|DP]] problem
 

# Explanation
---
This problem is pretty similar to [[yet another broken keyboard]] in that it's DP is local only to its adjacent states. 
However, a 2d DP grid is used instead, where `DP[N][x]` is equal to the maximum happiness achieved after $N$ days if the x'th option (from A,B,C) is picked on the Nth day. 

### base case
The base case is on day 1, in which the answer to each index is just the value of the activity on that day

### State transitions
The state transition for this problem is:
$$
dp[i][j]=max(\{n \in \{0,1,2\}\  |\  n \neq j\ \rightarrow dp[i-1][n]\})+happy[j]
$$
Which basically means to find the max happiness on the previous day achievable that doesn't use the same activity as the current index, and add the happiness that the current  index to that maximum result. 


# Revisit (14/06/24)

You can improve the space complexity to $\pmb{\mathcal{O}}(N)$ by reducing the dp structure from an array of $dp[i][j]$ where `i` is the current day and `j` is the choice of vacation, to simple $dp[j]$, since we only ever reference the previous day when making calculations. On atcoder, the millisecond running time and memory taken has been reduced to **16ms** and **8.6KB**, from the original **26ms** and **20.3KB**.

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<vector<int>> acts(n+1,vector<int>(3,0)); // activities
	for(int i = 0; i < n; i++)
	{
		cin >> acts[i][0] >> acts[i][1] >> acts[i][2];
	}
	
	vector<vector<int>> dp(n+1,vector<int>(3,0));
	dp[0][0] = acts[0][0];
	dp[0][1] = acts[0][1];
	dp[0][2] = acts[0][2];
	
	for(int i = 0; i < n; i++)
	{
		dp[i+1][0] = max(dp[i][1], dp[i][2]) + acts[i+1][0];
		dp[i+1][1] = max(dp[i][0], dp[i][2]) + acts[i+1][1];
		dp[i+1][2] = max(dp[i][0], dp[i][1]) + acts[i+1][2];
	}
	cout << max(dp[n-1][0], max(dp[n-1][1], dp[n-1][2]));
}
```


# Code (14/06/24)
---
```cpp

void solve()
{
	int n; cin >> n;
	vector<vector<int>> plan(n, vector<int>(3,0));
	int dp[3] = {0,0,0};
	int tmp[3] = {0,0,0};

	for(int i = 1; i <= n; i++)
	{
		for(int j = 0; j < 3; j++)
		{
			cin >> plan[i-1][j];
			int choice = 0;
			for(int k = 0; k < 3; k++)
			{
				if(j==k) continue;
				choice = max(choice, dp[k]);
			}
			tmp[j] = choice + plan[i-1][j];
		}
		dp[0] = tmp[0];
		dp[1] = tmp[1];
		dp[2] = tmp[2];
	}
	cout << max(dp[0], max(dp[1],dp[2])) << endl;
}
```