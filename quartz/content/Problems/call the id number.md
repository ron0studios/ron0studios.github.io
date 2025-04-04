# call the id number
---
>[!summary] A pretty straightforward atcoder problem


# Explanation
---
This one's a pretty simple [[ad hoc]] problem. Just keep track of everything

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> ids(n,0);
	for(int i = 0; i < n; i++) cin >> ids[i];
	vector<bool> called(200005, false);

	for(int i = 0; i < n; i++){
		if(not called[i+1]) called[ids[i]] = true;
	}

	vector<int> out;
	for(int i = 1; i <= n; i++){
		if(not called[i])
			out.pb(i);
	}
	cout << out.size() << endl;
	for(auto i : out)
		cout << i << " ";
}
```