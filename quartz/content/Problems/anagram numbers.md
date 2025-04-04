#bio
# Anagram numbers
---
> BIO 2010 Q1. easy question


# Explanation
---
simple [[Brute force]] required due to small test constraints. 


answer to (b):
	replace *  with / 
	print a/i

answer to (c):
    loop through non-duplicate numbers and do anagram check^[takes around 6 seconds to run]
# Code
---
```cpp

bool anagram(int a, int b)
{
	string n1 = to_string(a);
	string n2 = to_string(b);
	map<char,int> hm1;
	map<char,int> hm2;
	for(auto i : n1)
		hm1[i]++;
	for(auto i : n2)
		hm2[i]++;
	if(hm1 == hm2)
		return true;

	return false;

}

void solve(int tc)
{
	int a; cin >> a;

	bool found = false;
	for(int i = 2; i <= 9; i++)
	{
		if(anagram(a,a*i))
		{
			found = true; 
			cout << i << " ";
		}
	}
	if(!found)
		cout << "NO\n";
	else
		cout << "\n";

}


```