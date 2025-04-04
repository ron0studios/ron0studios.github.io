# static range sum
---
> A very basic problem requiring usage of the [[prefix sum]]


# Explanation
---
You aren't able to solve this by manually adding between the two indexes, since this would have a time comeplexity of $O(N^2)$, which will TLE for most test cases. Use the [[prefix sum]] array instead.

# Code
---
```cpp
void solve(int tc)
{
	ll N, Q; cin >> N >> Q; 
	vector<ll> seq; inveci(N,seq);
	vector<ll> pref = {seq[0]}; // account for 0-indexing

	// calculate prefix array
	for(int i = 1; i < seq.size(); i++)
	{
		pref.pb(pref.back() + seq[i]);
	}

	// console printing
	cout << "The prefix array: \n";
	for(auto i : pref) cout << i << " "; 
	cout << "\n\n";

	for(ll i = 0; i < Q; i++)
	{
		ll l, r; cin >> l >> r;
		ll sum = 0;
		sum = pref[r-1] - pref[l-1];

		cout << sum << "\n"; // answer
	}
}
```