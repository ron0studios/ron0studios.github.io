# alternating subsequence
---
>[!summary] A Codeforces problem


# Explanation
---
This is a [[Greedy]] problem that uses [[dynamic programming]] techniques. 

The technique in question is the $\pmb{\mathcal{O}(Nlog(N))}$ solution to the [[longest increasing subsequence]], which uses a DP array that is progressively constructed.

In [[longest increasing subsequence|LIS]], the state at each point in the algorithm is `dp[x]` where x is the smallest-ending element of a subsequence with size `x`. 
In our case it is also a subsequence of size `x`, but this time it's not the smallest ending, but rather the biggest ending, and following the alternating sign rule. 

We also don't have to search through the array, but rather only modify the last element greedily, yielding us a time complexity of $\pmb{\mathcal{O}(N)}$.

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<ll> a(n,0); 
	for(int i = 0; i < n; i++)
		cin >> a[i];
	vector<ll> dp{a[0]}; 
	for(int i = 1; i < n; i++)
	{
		if(signbit(a[i]) != signbit(dp.back()))
		{
			dp.pb(a[i]);
		}
		else
		{
			if(a[i] > dp.back())
			{
				dp.back() = a[i];
			}
		}
	}
	cout << accumulate(dp.begin(),dp.end(),0LL) << "\n";
}
```