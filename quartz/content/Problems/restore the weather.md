# restore the weather
---
>[!summary] A codeforces problem


# Explanation
---
This is a [[Greedy]] [[sorting]] problem. 

# Code
---
```cpp
void solve(int tc)
{
	int n, k; cin >> n >> k;
	vector<pair<int,int>> a(n,{0,0});
	vector<int> b(n,0);
	vector<pair<int,int>> b1(n,{0,0});
	for(int i = 0; i < n; i++){
		int x; cin >> x;
		a[i] = mp(x,i);
	}
	for(int i = 0; i < n; i++){
		int x; cin >> x;
		b[i] = x;
		b1[i] = mp(x,i);
	}

	sort(a.begin(),a.end());
	sort(b1.begin(),b1.end());

	vector<pair<int,int>> c(n,{0,0});
	for(int i = 0; i < n; i++)
	{
		c[i] = mp(a[i].second,b1[i].second);
	}

	sort(c.begin(),c.end());



	vector<int> out(n,0);
	for(int i = 0; i < n; i++)
	{
		out[i] = b[c[i].second];
	}

	for(auto i : out)
		cout << i << " ";
	cout << endl;
}
```