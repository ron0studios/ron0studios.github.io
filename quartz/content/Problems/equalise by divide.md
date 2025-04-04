# equalise by divide
---
>[!summary] Does this


# Explanation
---
a relatively straightforward, but weird, [[Greedy]] [[maths]] problem, where you divide the biggest number by the smallest. 

# Code
---
```cpp
bool equal(vector<ll> a)
{
	for(int i = 1; i < (int)a.size(); i++)
	{
		if(a[i] != a[i-1]) return false;
	}
	return true;
}

void solve(int tc)
{
	int n; cin >> n;
	vector<ll> a(n, 0);
	for(int i = 0; i < n; i++)
		cin >> a[i];
	vector<pair<int,int>> ops;
	int stop = 0;

	while(not equal(a) and stop <= 31*n)
	{
		auto i = max_element(a.begin(),a.end());
		auto j = min_element(a.begin(),a.end());
		ops.pb(mp(i-a.begin(), j-a.begin()));
		a[ops.back().first] = ceil((float)a[ops.back().first]/a[ops.back().second]);
		stop++;
	}
	if(stop==(31*n)+1){
		cout << -1 << endl;
		return;
	}

	cout << ops.size() << endl;
	for(auto i : ops)
	{
		cout << i.first+1 << " " << i.second+1 << endl;
	}
}
```