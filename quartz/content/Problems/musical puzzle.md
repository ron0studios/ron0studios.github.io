# musical puzzle
---
>[!summary] simple codeforces problem


# Explanation
---

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	string s; cin >> s;
	unordered_map<string,int> cnt;
	for(int i = 0; i < n-1; i++){
		cnt[s.substr(i,2)]++;
	}

	int o = 0;
	for(auto i : cnt) o++;

	cout << o << "\n";
}
```