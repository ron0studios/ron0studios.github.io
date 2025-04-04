# creating strings
---
>[!summary] A cses problem that can be done easily using stl


# Explanation
---
There are 2 ways of doing this problem:
- You could use `next_permutation`, to run through all permutations automatically, but remember to **[[complete search#Generating permutations|sort]]** before doing this!  
- You can also do this [[recursion|recursively]]:
	- The states include a string representing the current permutation and a `pool`, which represents letters that are left to select
	- In order to exclude permutations over the same letters we include a [[hash map]] maintaining the letters that have already been recursed to in each instance of the function. Therefore, for example, if we had 3 A's in our pool, then it there won't be 3 different recursions including an *A* at the end of `cur`. 

# Code
---
### STL solution
```cpp
void solve()
{
	string s; cin >> s;
	sort(s.begin(),s.end());
	vector<string> perms;
	do{
		perms.pb(s);
	}
	while(next_permutation(s.begin(),s.end()));

	cout << perms.size() << "\n";
	for(auto i : perms)
		cout << i << "\n";
	
}
```

### Recursive solution
```cpp
vector<string> perms;

void compute(string cur, string pool)
{
	if(!pool.length())
	{
		perms.pb(cur);
	}
	else
	{
		unordered_map<char,bool> used; 
		for(int i = 0; i < pool.size(); i++)
		{
			string tmp = pool;
			if(used.count(pool[i])) continue;
			used[pool[i]] = true;
			tmp.erase(tmp.begin()+i);
			compute(cur+pool[i],tmp);
		}
	}
}

void solve()
{
	string s; cin >> s;
	sort(s.begin(), s.end());
	compute("",s);

	cout << perms.size() << "\n";
	for(auto i : perms)
		cout << i << "\n";
}
```