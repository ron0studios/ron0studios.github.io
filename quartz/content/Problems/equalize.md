# equalize
---
>[!summary] Fun Codeforces dp problem


# Explanation
---
This is a pretty weird [[dynamic programming]] problem, similar to [[alphacode]]. 

Let's first declare our dp structure:
$$
dp[x], \text{where } x \text{ is the min operations needed to make } \pmb{a[:x]} \text{ into } \pmb{b[:x]}
$$
We won't need to tamper much with the dp default values, let's just leave them at 0. 

The base case is $dp[0]$, where both **a** and **b** are empty, therefore being 0. 

### Observation
---
There are 2 possible options we can do to a bit. We can either swap it with another index for the cost $\pmb{|\ i-j\ |}$, or we can just flip the bit for a cost of **1**.

The main observation here is that swapping is the same as flipping both bits at index i and index j. Therefore, if the distance between i and j is $> 2$ , then the cost of swapping will be greater than the cost of just flipping them individually. 

What we can then conclude, is that the only scenario where swapping is cheaper than flipping is if we're swapping between two adjacent indices, such as from **01** to **10**, since the flipping cost would be **2**, but the swapping cost would be **1**. 

**however,** the swap is only cheaper if we actually have the bit we need! If we had **11** and we needed **10**, swapping wouldn't do anything! It would only work if $a[i-1] = b[i]$ , i.e if the previous bit we're swapping with actually has the bit we need to make the two equal! 

### Transitions
---
From these observations, we can then just conclude that in the scenario where we just flip a bit, the solution is $dp[i-1]+1$.
If we want to swap a bit, then the solution is $dp[i-2]+1$. 
Why? Well because we would have been effecting the state of $dp[i-1]$ too by swapping, sort of like in [[alphacode]], since both $a[i]$ and $a[i-1]$ are swapped. Whatever costs were in the subproblem $dp[i-1]$ don't matter, because we're kind of overriding them with this swap. 
Instead we replace both cells with a single cost **1** operation for a swap, and look to the subproblem with unaffected cells, which is $dp[i-2]$, hence $dp[i-2]+1$.

Our final transition is as follows:
$$
dp[i] = min \cases{
dp[i-1]+1  \\
dp[i-2]+1 & a[i-1]=b[i],
}
$$


# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	string a, b; cin >> a >> b;

	vector<ll> dp(n+1);
	for(int i = 1; i <= n; i++)
	{
		if(a[i-1] == b[i-1])
		{
			dp[i] = dp[i-1];
			continue;
		}

		ll change = dp[i-1] + 1; 
		ll swap = LLONG_MAX; 
		if(i >= 2 and a[i-2] == b[i-1]) swap = dp[i-2]+1;
		dp[i] = min(change,swap);
	}

	cout << dp[n];

}
```


