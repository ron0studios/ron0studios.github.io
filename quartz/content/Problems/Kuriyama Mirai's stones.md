# Kuriyama Mirai's stones
---
>[!summary] Pretty simple DP problem codeforces


# Explanation
---
This is a [[prefix sum]] problem. 
You create 2 prefix sums, one for the original input and another for the [[sorting|sorted]] stones. You then simply process the [[range query|queries]]. 

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> stones(n,0);
	for(int i = 0; i < n; i++)
		cin >> stones[i];
	int m; cin >> m;
	vector<vector<int>> queries(m,vector<int>(3,0));
	for(int i = 0; i < m; i++)
		cin >> queries[i][0] >> queries[i][1] >> queries[i][2];

	// type 1
	vector<ll> pref1 = {0};
	for(int i = 0; i < n; i++)
		pref1.pb(pref1.back()+stones[i]);
		
	// type 2
	sort(stones.begin(), stones.end());
	vector<ll> pref2 = {0};
	for(int i = 0; i < n; i++)
		pref2.pb(pref2.back()+stones[i]);
		
	for(auto q : queries)
	{
		if(q[0] == 1)
		{
			cout << pref1[q[2]] - pref1[q[1]-1] << "\n";
		}
		else
		{
			cout << pref2[q[2]] - pref2[q[1]-1] << "\n";
		}
	}
}
```