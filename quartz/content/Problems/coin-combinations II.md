# coin combinations II
---
> Similar to [[coin-combinations I]],  but instead of finding out all combinations, we want **distinct** combinations


# Explanation
---
As always, we use [[dynamic programming]] to solve this problem. You have to be careful when implementing this, although you may be able to solve it using [[combinatorics]] knowledge, it will be much easier to do it like this! A big distinction between this problem and problems where having distinct answers *doesnt* matter, is that you want to preserve order. Therefore, the best way to do these types of problems is with a 2d [[matrix]], where each row is your typical N+1 dp array, but we also have X rows where X is the number of coins.

Essentially what we are doing, is that we are breaking down the states to when we have a certain amount of coins. And since we are pooling coins in a fixed order, we have found distinct solutions. 

Here's another way of looking at it:

If we take all the result for a single coin, which took its results from another coin, instead of doing it cumulatively, then we end up constricting the order and only considering distinct options

## Update after re-doing problem
---
> Here is a *much* better way of looking at it. 

Each new row of the table always has the inclusion of a new coin among the coins we can use. This can mean that when we make state transitions, we are considering whether we should include a coin ($dp[i][j-c[i]]$)  or not ($dp[i-1][j]$), because the previous row does *not* include the coin that we're considering. And then for each row, we just do regular coin combinations, adding on the result when substracting the value of the coin. 
watch this video for clarity
its basically [[the knapsack problem]]
<iframe width="560" height="315" src="https://www.youtube.com/embed/DJ4a7cmjZY0?start=228" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# Code
---
```c++
void solve(int tc)
{
	int N, X; cin >> N >> X;
	vector<int> a; inveci(N,a)
	vector<vector<int>> memo(N+1, vector<int>(X+1, 0));

	memo[0][0] = 1;

	for(int i = 1; i <= N; i++)
	{
		for(int j = 0; j <= X; j++)
		{
			memo[i][j] = memo[i-1][j];
			int coin = a[i-1];
			if(j-coin >= 0)
			{
				memo[i][j] += memo[i][j-coin];
				memo[i][j] %= MOD;
			}
		}
	}

	cout << memo[N][X] << "\n";

}
```