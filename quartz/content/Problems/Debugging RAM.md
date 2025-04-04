# Debugging RAM
---
>[!summary] UVA 11736. A nice and fun problem, but be careful with the large value edge cases! Took around 25 minutes


# Explanation
---
This [[ad hoc]] problem is an interesting simulation of real life RAM storage. It is quite simple to carry out, and can be made simpler by using a few tricks I learnt about recently.
### converting to binary
Usually when doing this, the standard procedure would be to keep subtracting powers of 2 until you approach the value you need. However **C++11**  introduces us a better way of converting from [[string|strings]] to other bases.
```cpp
int x = stoi(y, nullptr, 2)
```
where 2 is the base we want to convert to (binary). 

This is significantly easier and saves a lot of time. If you want this to work for other data types, such as in this case `unsigned long long`, then you can use something like `stoull`. Just look at the acronyms!


# Code
---
```cpp
void solve(int b, int v)
{
	vector<pair<string,int>> vars;
	int ramsize = 0;
	for(int i = 0; i < v; i++){
		string s; int l;
		cin >> s >> l;
		vars.pb(mp(s,l));
		ramsize += l;
	}

	unordered_map<string, unsigned long long> vals;
	for(int i =0 ; i < v; i++){
		string tmp = "";
		for(int j = 0; j < vars[i].second; j++){
			string s;
			cin >> s;
			tmp += s;
		}

		vals[vars[i].first] = stoull(tmp,nullptr,2);
	}

	int checks; cin >> checks;

	for(int i = 0; i < checks; i++){
		string var; cin >> var; 
		if(vals.count(var)) {
			cout << var << "=" << vals[var] << endl;
		} else { 
			cout << var << "=" << endl;
		}
	}

}
```