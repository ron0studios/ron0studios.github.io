# out of place
---
>[!summary] usaco bronze problem


# Explanation
---
#tofinish


# Code
---
```cpp

void solve()
{
	freopen("outofplace.in","r",stdin);
	freopen("outofplace.out","w",stdout);
	int n; cin >> n;
	vector<int> cows(n,0);

	for(int i = 0; i < n; i++)
	{
		cin >> cows[i];
	}
	int c = 0;

	vector<int> sorted = cows;
	sort(sorted.begin(), sorted.end());
	for(int i = 0; i < n; i++)
		if(cows[i] != sorted[i])
			c++; // lol
	cout << max(0,c-1);
}


```