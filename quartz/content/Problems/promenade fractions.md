#bio
# promenade fractions
---
> Confusing BIO 2015 Q1


# Explanation
---
This problem was just confusing and hard to understand what was being asked of you, but besides that it was actually pretty easy! 

# Code
---
```cpp
void solve(int tc)
{
	pair<int,int> left  = {1,0}; int lc = 0;
	pair<int,int> right = {0,1}; int rc = 0;
	string q; cin >> q;

	pair<int,int> out = {0,0};
	out = left + right; // initial
	for(auto i : q)
	{
		if(i=='L')
		{
			left = out; lc++; // before most recent

			out = left + right;
		}
		else
		{
			right = out; rc++; // before most recent
			
			out = left+ right;
		}
	}

	cout << out.first << " " << out.second;

}
```