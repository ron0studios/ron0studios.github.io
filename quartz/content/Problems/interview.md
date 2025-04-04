# interview
---
>[!summary] a fun codeforces interactive problem


# Explanation
---
This is my first ever interactive problem 😄.

This requires a combination of [[binary search]] and [[recursion]].

Essentially, every pile of stones is going to have a weight equal to its number of stones, so if we, first, create a [[prefix sum]] to get sum calculations for the number of stones and then compare a sum of the count with a queried (from the oracle) sum of the weights in a certain interview, we can use binary search (recursively) to check for rest of the data. 

For example, if the count of stones is the same as the weight of the stones in the first half of the piles, then we know the special stone isnt there and therefore check the other half and its quarters.


# Code
---
```cpp

int n;
vector<int> stones;
vector<ll> pref;

bool compute(int l, int r, bool noreq=false){
	if(r-l == 0) {
		cout << "? 1 " << r+1 << endl;
		int res; cin >> res;
		if(res == stones[r]) return false;
		cout << "! " << r+1 << endl;
		return true;
	}

	if(noreq)
	{
		bool left = compute(l, floor((l+r)/2.0f));
		if(left) return true;
		bool right = compute(floor((l+r)/2.0f)+1,r, true);
		if(right) return true;
		return false;
	}
	else
	{
		cout << "? " << r-l+1 << " ";
		for(int i = l+1; i <= r+1; i++)
			cout << i << " ";
		cout << endl;

		ll sum; cin >> sum;
		ll csum = pref[r];
		if(l) csum -= pref[l-1];
		if(csum!=sum){
			bool left = compute(l, floor((l+r)/2.0f));
			if(left) return true;
			bool right = compute(floor((l+r)/2.0f)+1,r, true);
			if(right) return true;
		}
		return false;
	}
}

void solve(int tc)
{
	cin >> n;
	stones = vector<int>(n,0);
	pref = vector<ll>();

	for(int i = 0; i < n; i++){
		cin >> stones[i];
		if(pref.size())
			pref.pb(pref.back() + stones[i]);
		else
			pref.pb(stones[i]);
	}

	if(n==1){
		cout << "! " << 1 << endl;
		return;
	}

	bool left = compute(0,floor((n-1)/2.0f));
	if(left) return;
	bool right = compute(floor((n-1)/2.0f)+1,n-1,true);

}
```