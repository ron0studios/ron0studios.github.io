# odd queries
---
>[!summary] easy codeforces problem


# Explanation
---
This is a querying problem that requires a [[prefix sum]]. 
We can use the prefix sum to quickly calculate the current sum of the array at an interval $[l,r]$. We then calculate what the **new** sum would be by getting the difference between the sum of the interval and substracting it from $X$ times the interval size, then adding that onto the sum of the total array.

# Code
---
```cpp
void solve(int tc)
{
	int n,q; cin >> n >> q;
	vector<ll> arr(n,0);
	vector<ll> pref;
	for(int i = 0; i < n; i++)
	{
		cin >> arr[i];
		if(pref.size())
			pref.pb(pref.back()+arr[i]);
		else
			pref.pb(arr[i]);
	}

	for(int qtmp = 0; qtmp < q; qtmp++){
		ll l; cin >> l; l--;
		ll r; cin >> r; r--;
		ll x; cin >> x;

		ll oldsum = pref[r];
		if(l) oldsum -= pref[l-1];

		ll qsum = (l-r+1)*x;


		ll newsum = (qsum-oldsum)+pref.back();
		if(newsum % 2)
			cout << "YES\n";
		else
			cout << "NO\n";
	}
}
```