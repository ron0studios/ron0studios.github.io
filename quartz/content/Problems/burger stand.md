# burger stand
---
>[!summary] UVA 13048. simple problem. Took 10 minutes


# Explanation
---
This problem just requires you to follow the basic rules of the system. It is therefore [[ad hoc]] in nature. Note that you should be wary of indexing *within* bounds, so you should add a precautionary check before indexing with +-1 or 2.
# Code
---
```cpp
void solve(int tc)
{
	string s; cin >> s;
	int n = (int)s.size();
	int o = 0;
	for(int i = 0; i < n; i++) {
		if(s[i] != '-') continue;
		if(i+1 < n and (s[i+1] == 'B' or s[i+1] == 'S'))
			continue;
		if(i+2 < n and s[i+2] == 'B') continue;
		if(i-1 >= 0 and s[i-1] == 'S') continue;
		o++;
	}

	cout << "Case " << tc << ": ";
	cout << o << endl;

}
```