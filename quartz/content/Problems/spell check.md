# spell check
---
>[!summary] easy cf problem


# Explanation
---
You basically just use [[complete search#Iteratively|iterative complete search]] and [[complete search#Generating permutations|generate permutations]]. 
>[!warning]
>avoid `is_permutation` 

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	string s; cin >> s;
	
	string check = "Timur";
	sort(check.begin(),check.end());
	
	do{
		if(check == s)
		{
			cout << "YES\n"; return;
		}
	}
	while(next_permutation(check.begin(),check.end()));
	cout << "NO\n";
}
```