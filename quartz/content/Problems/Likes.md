# Likes
---
>[!summary] Simple CF problem


# Explanation
---
This is a [[Greedy]] problem that requires just a lot of [[sorting]] to get right. Just try out a couple of testcases with pen and paper.


# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> b(n,0);
	for(int i = 0; i < n; i++)
		cin >> b[i];

	vector<int> c = b;
	sort(c.begin(), c.end(), greater<int>());

	for(auto &i : b)
		if(i > 0)
			i = 1;
		else
			i = -1;

	sort(b.begin(), b.end(), greater<int>());

	map<int,bool> hasneg;
	for(int i = 0; i < n; i++)
		if(c[i] < 0){
			hasneg[-c[i]] = true;
		}

	vector<int> newc;
	for(auto i : hasneg)
	{
		newc.pb(1);
		newc.pb(-1);
	}
	for(int i = (int)newc.size(); i < n; i++)
		newc.pb(1);


	int max = 0;
	for(int i = 0; i < n; i++){
		cout << max+b[i] << " ";
		max += b[i];
	}
	cout << endl;
	int min = 0;
	for(int i = 0; i < n; i++) {
		cout << min+newc[i] << " ";
		min += newc[i];
	}
	cout << endl;
}
```
