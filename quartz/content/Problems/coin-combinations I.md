# Coin Combinations I
---
> A [[dynamic programming]] problem, similar to [[dice-combinations]], except instead of dice, you use a given set of coin values.


# Explanation
---
We use [[dynamic programming]], to solve this by, firstly, taking an array of values^[the array size is **N+1**, not just N!]. From this array of values, we sum up the previous results of N-x, N-y, N-x .... for every coin in our list. I am not sure if there is an easier way of doing this with [[combinatorics]] knowledge,  but right now this method seems easy enough. 

# Code
---
```c++
void solve(int tc)
{
	int N, X; cin >> N >> X;
	vector<ll> a; inveci(N,a)

	vector<ll> memo(X+1, 0);
	memo[0] = 1;

	for(int i = 0; i <= X; i++)
	{
		for(auto j : a)
		{
			if(i-j >= 0)
			{
				memo[i] += memo[i-j];
				memo[i] = memo[i] % MOD; // Always remember to MOD!!! (if asked)
			}
		}
	}

	cout << memo[X] << "\n";
}
```