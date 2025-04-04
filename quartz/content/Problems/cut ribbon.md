# cut ribbon
---
>[!summary] Interesting codeforces problem

# Explanation
---
This is a twist of the classic [[dynamic programming]] problem, [[Coin Change]]. Please read the solution to coin change before progressing. 
> [!Coin change problem]- 
> ![[Coin Change]]

The main difference here is that this problem is more *situational*, because there are cases where it is in-fact impossible to cut the ribbon meeting the requirements. 

The solution here is a small change in the DP contents. 
Usually the dp array is initialized as follows:

| 0   | 0   | 0   | 0   | ... |
| --- | --- | --- | --- | --- |

This time, we set index 0, a ribbon of length 0, to 0^[that's a lot of 0's lol], but this time set every other element to $-1$, which indicates a solution is impossible. 

Now when we recurse through all the ribbon cuts, we can check if the state is equal to -1 or not. If it is, then we don't consider it. 

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> abc(3); cin >> abc[0] >> abc[1] >> abc[2];
	vector<int> dp(n+1,-1);
	dp[0] = 0;

	for(int i = 1; i <= n; i++)
	{
		for(auto j : abc)
		{
			if(i-j < 0) continue;
			if(dp[i-j] == -1) continue;
			dp[i] = max(dp[i],dp[i-j]+1);
		}
	}
	cout << dp[n];
}
```