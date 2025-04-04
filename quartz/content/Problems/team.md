# team
---
>[!summary] Hyper-easy codeforces problem, so i can maintain my streak :P


# Explanation
---
[[ad hoc]]
# Code
---
```cpp
void solve()
{
	int n; cin >> n; 
	int out = 0;
	for(int i = 0; i < n; i++)
	{
		int a,b,c; cin >> a >> b >> c;
		if( a + b + c > 1)
			out++;
	}
	cout << out;
}
```