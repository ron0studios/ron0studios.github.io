# vitamins
---
>[!summary] Interesting DP problem


# Explanation
---
This problem involves [[bitwise operations]] and [[dynamic programming]]. 
It is a twist on the classical [[the knapsack problem|knapsack problem]], in that instead of having singular objects, you now have sets of objects.
In order to solve this, instead of using regular pull DP, push DP is far more suitable.

**In push DP, you see whether or how a subproblem should contribute to full solutions. **

First we define the dp [[matrix|grid]]:

> **dp\[i\]\[j\]** where the first **i** drinks are used that satisfy the **j'th** mask of vitamins

### masks
---
What are the masks here?

Well we consider the mask as a 3-bit binary number, where the biggest bit represents whether A is included, the second whether B is included, and the third whether C is. 

We can therefore list all possible masks incrementally as follows:

| 000 | 001 | 010 | 011 | 100 | 101 | 110 | 111 | 
| --- | --- | --- | --- | --- | --- | --- | --- | 
<center><i>There are 8 total states</i></center>

### Base cases
---
The base case is when the mask is *000*, in which it always costs 0. Everything else is $\infty$. 



### transitions
---
Let's consider the cases where this subproblem contributes to a solution

Firstly is the case where a subproblem can be set to a solution of the same mask but more available drinks.
In this case `dp[i+1][j] = min(dp[i+1][j], dp[i][j])`. 

This is saying that we **can** either set the solution with the same mask but an extra available drink to the current value, `dp[i][j]`, or we can just leave it as be, `dp[i+1][j]`. We take the minimum of these two options. 

There is also the case where a subproblem **contributes** to a solution that includes the elements in the current mask. For example `001` could contribute to `011` or `110` could contribute to `111`. 
In this case `dp[i+1][j | masks[i]] = min(dp[i+1][j | masks[i]], dp[i][j] + cost[i])`
This is saying that we **can** either contribute this subproblem with it's cost, or just leave the solution be.


# Code
---
```cpp

void solve()
{
	int n; cin >> n;
	vector<ll> juice(n,0);
	vector<ll> cost(n,0);
	for(int i = 0; i < n; i++)
	{
		int c; string s; cin >> c >> s;
		cost[i] = c;

		int mask = 0; 
		for(int j = 0; j < 3; j++)
		{
			char tmp = 'C'-j;
			bool have = false;
			for(auto k : s)
			{
				if(tmp == k){
					have = true;
				}
			}
			if(have)
			{
				mask += pow(2,j);
			}
		}
		juice[i] = mask;
	}

	vector<vector<ll>> dp(n+1, vector<ll>(8,INF));

	for(int i = 0; i <= n; i++)
		dp[i][0] = 0; 

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < 8; j++)
		{
			//ll with, without; 
			//without = dp[i-1][j];
			//with = dp[i-1][j ^ juice[i-1] ] + cost[i-1];
			//dp[i][j] = min(with,without);

			dp[i+1][j] = min(dp[i+1][j], dp[i][j]);
			dp[i+1][j | juice[i]] = min(dp[i+1][j | juice[i]], dp[i][j] + cost[i]);
		}
	}


	/*
	for(auto i : dp){
		for(auto j : i)
			cout << (j==INF ? "X" : to_string(j)) << " ";
		cout << endl;
	}
	*/

	cout << (dp.back().back()==INF ? -1 : dp.back().back() );

}


```