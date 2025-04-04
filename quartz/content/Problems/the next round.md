# the next round
---
>[!summary] to maintain my streak. hyper easy codeforces problem


# Explanation
---
[[ad hoc]]
# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	int k; cin >> k;
	vector<int> c(n,0);
	for(int i = 0; i < n; i++)
		cin >> c[i];
	int out = 0;
	for(int i = 0; i < n; i++)
	{
		if(c[i]<=0) continue;
		if(c[i] < c[k-1]) continue;
		out ++;
	}

	cout << out;

}
```