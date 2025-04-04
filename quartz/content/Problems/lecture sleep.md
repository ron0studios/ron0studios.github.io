# lecture sleep
---
>[!summary] relatively simple Codeforces problem


# Explanation
---
This problem is a pretty simple [[prefix sum]] problem. It is essentially a [[max subarray sum]] problem in disguise, and with a limited subarray size. 

# Code
---
```cpp


void solve()
{
	int n, k; cin >> n >> k;
	vector<int> values(n, 0);
	vector<int> awake(n, 0);
	for(int i = 0; i < n; i++)
		cin >> values[i];
	for(int i = 0; i < n; i++)
		cin >> awake[i];


	vector<int> tot(n,0);
	int curtotal = 0;
	for(int i = 0; i < n; i++){
		tot[i] = values[i]*(not awake[i]);
		curtotal += values[i]*awake[i];
	}
	
	vector<int> pref(n+1,0);
	for(int i = 0; i < n; i++)
		pref[i+1] = pref[i] + tot[i];

	int a = 1; 
	int b = k;
	int maxadd = -1;
	while(b <= n)
	{
		maxadd = max(maxadd, pref[b]-pref[a-1]);
		b += 1;
		a += 1;
	}

	cout << curtotal + maxadd;


}


```