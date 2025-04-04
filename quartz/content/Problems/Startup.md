# Startup
---
>[!summary] Codeforces 2036B. simplish problem. Took 5 minutes


# Explanation
---
Just need a [[hash map]] of the various bottle brands and pick the `n` biggest ones using [[sorting]]. It is basically a [[Greedy]] approach to the problem, and sufficient for the test cases.
# Code
---
```cpp

void solve(int tc)
{
	int n, k; cin >> n >> k;
	unordered_map<int, vector<int>> bot;
	for(int i = 0; i < k; i++){
		int a,b; cin >> a >> b;
		bot[a].pb(b);
	}

	vector<int> sums;
	for(auto i : bot){
		sums.pb(accumulate(i.second.begin(), i.second.end(), 0));
	}
	sort(sums.begin(), sums.end(), greater<int>());

	int out =0 ;
	for(int i = 0; i < n; i++){
		if(i == sums.size()) break;
		out += sums[i];
	}

	cout << out << endl;

}


```