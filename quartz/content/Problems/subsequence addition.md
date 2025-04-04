# subsequence addition
---
>[!summary] simple codeforces problem


# Explanation
---
This is a [[Greedy]] problem where you just work backwards. 

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];
	sort(a.begin(),a.end(), greater<int>());

	for(int i = 0; i < n; i++){
		int target = a[i];
		if(target == 1){ cout << "YES\n"; return;}
		for(int j = i+1; j < n; j++)
		{
			if(target == 0) break;
			if(a[j] <= target) target -= a[j];
		}
		if(target != 0){ cout << "NO\n"; return;}
	}
}
```