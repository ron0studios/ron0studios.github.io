# vlad building beautiful array
---
>[!summary] pretty simple codeforces problem


# Explanation
---
a pretty simple [[Greedy]] problem.

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];

	int omax, omin, emax, emin;
	omax = -INT_MAX; omin = INT_MAX;
	emax = -INT_MAX; emin = INT_MAX;

	for(int i = 0; i < n; i++)
	{
		if(a[i] % 2)
		{
			omax = max(omax, a[i]);
			omin = min(omin, a[i]);
		}
		else
		{
			emax = max(emax, a[i]);
			emin = min(emax, a[i]);
		}
	}


	bool allodd = true; bool alleven = true;

	// try to make all odd
	for(int i = 0; i < n; i++)
	{
		if(a[i] % 2 == 0)
		{
			if(a[i]-omin <= 0) {
				allodd =false;
				break;
			}
		}
	}

	// try to make all even
	for(int i = 0; i < n; i++)
	{
		if(a[i] % 2)
		{
			if(a[i]-omin <= 0){
				alleven = false;
				break;
			}
		}
	}

	if(allodd or alleven)
		cout << "YES\n";
	else
		cout << "NO\n";


}
```