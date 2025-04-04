# just eat it
---
>[!summary] Relatively simple codeforces [[dynamic programming|DP]] with a twist


# Explanation
---
This works similarly to [[LCS]] in terms of its dp structure, but follows more closely along the lines of a *subarray* than a subsequence. 

Yasser's situation is simple, we just sum up the array in $\pmb{\mathcal{O}(N)}$. 

For Abel though, we need to find the [[the maximum subarray|max subarray]] in the sequence, which can also be done in $\pmb{\mathcal{O}(N)}$!

we set up our dp as follows:
$$
dp[x], \text{where } x \text{ represents the largest value subarray ending at a[x]}
$$
The base case is $dp[0]$, which is set to $a[0]$.

### transitions
---

From there on we *would* just use the following state transition
$$
dp[i] = max\cases{dp[i-1]+a[i], \\a[i]}
$$
Here's the problem though, the question specifies that the length of the max subarray cannot be the entire array, meaning that it must be of length < *N*. 

To solve this, we can check whether the dp solution *breaks* at any point, i.e if the second transition occurs, meaning that the optimum subarray starts at index *i* and not 0. 

If there hasn't been such a breakage, then for the last index, we can conclude that the max subarray ending at the last index is just the entire array. To counteract this, we just subtract the first index of the array (the base case) from $dp[n-1]$ (the last index). 

Lastly, the solution for abel is the max value in the dp array. 

Overall this takes $\pmb{\mathcal{O}(N)}$ time. 

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];

	vector<ll> dp(n,0);
	dp[0] = a[0];

	bool broke = false;
	for(int i = 1; i < n; i++)
	{
		dp[i] = max(dp[i-1] + a[i], (ll)a[i]);
		if(dp[i] == (ll)a[i]) broke = true;
	}
	if(!broke) dp[n-1] -= dp[0];
	ll abel = *max_element(dp.begin(), dp.end());
	ll yasser = accumulate(a.begin(), a.end(),0LL);

	if(yasser > abel)
	{
		cout << "YES\n";
	}
	else
	{
		cout << "NO\n";
	}
}
```