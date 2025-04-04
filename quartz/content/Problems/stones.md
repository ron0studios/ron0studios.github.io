# stones
---
>[!summary] Atcoder dp educational problem


# Explanation
---
This is a 1D [[dynamic programming]] problem.

let `dp[x]` be an array where `x` refers to whether the first player to move with a pile of size `x` will win. 

### transitions
---
Our state transitions, therefore, are as follows:
- For each element in the DP array:
	- If any of the DP states, in `dp[i-k]`, where k represents the value of a stone, are reachable and are 0, set the current dp state to 1.

This works because, if a DP state is 0, it means if a player started with a pile of `x` it means they won't win but the player after them (player 2) will. This means if we take `dp[i+k]`, i.e the current state, then the player in that state makes their move to the `dp[i-k]`, state, which the opponent is now in, and will therefore lose on.

# Code
---
```cpp
void solve()
{
	int n, k; cin >> n >> k;
	vector<int> stones(n,0);
	for(int i = 0; i < n; i++) cin >> stones[i];

	vector<int> dp(k+1,0);
	for(int i = 0; i < dp.size(); i++)
	{
		for(auto j : stones)
		{
			if(i-j >= 0 and !dp[i-j])
			{
				dp[i] = 1;
			}
		}
	}
	cout << (dp.back() ? "First" : "Second");
}
```