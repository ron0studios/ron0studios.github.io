---
aliases: 
date: 
time taken (mins):
---


# one time swap
---
>[!summary] atcoder 345 C. Interesting [[complete search]] problem. took 15 mins


# Explanation
---

# Code
---
```cpp
void solve()
{
	vector<ll> counts(26);
	string s; cin >> s;
	for(auto i : s)
		counts[i-'a']++;

	
	ll out = 0;
	for(int i = 0; i < 26; i++){
		for(int j = i+1; j < 26; j++){
			out += counts[i]*counts[j];
		}
	}

	for(int i = 0; i < 26; i++){
		if(counts[i] > 1){
			out++;
			break;
		}
	}

	cout << out << endl;
}
```