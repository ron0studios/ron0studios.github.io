# longest path
---
>[!summary] Alright atcoder problem


# Explanation
---
This requires knowledge on [[graph]] algorithms.

You run a [[DFS]] for each node, and maintain a [[dynamic programming|DP]] array for the longest path up to a node.

# Code
---
```cpp
unordered_map<int, vector<int>> nodelist;
vector<int> dp;

int dfs(int node)
{
	if(dp[node] != -1) return dp[node];

	int longest_child = -1;
	for(auto i : nodelist[node])
	{
		longest_child = max(longest_child, dfs(i));
	}
	return dp[node] = longest_child + 1; // bcs of the extra edge
}

void solve()
{
	int n, m; cin >> n >> m;

	for(int i = 0; i < m; i++)
	{
		int x, y; cin >> x >> y;
		nodelist[x].pb(y);
	}

	dp = vector<int>(n+1,-1);

	int out = 0;
	for(int i = 1; i <= n; i++)
	{
		out = max(out, dfs(i));
	}

	cout << out;

}
```