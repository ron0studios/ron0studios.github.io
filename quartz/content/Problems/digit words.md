#bio
# Digit words
---
> 2009 BIO q1


# Explanation
---

# Code
---
```cpp
vector<string> nums = {"ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE"};


void solve(int tc)
{
	string s; cin >> s; 
	for(int i = 0; i < nums.size(); i++)
	{
		string tmpi = nums[i]; 
		string tmps = s;
		
		while(tmps.length() > 0)
		{
			char x = tmps[0]; tmps.erase(tmps.begin());
			if(x == tmpi[0]){
				tmpi.erase(tmpi.begin());
			}
			if(tmpi.length() == 0)
			{
				cout << "YES\n";
				cout << i+1 << "\n";
				return;
			}
		}

	}
	cout << "NO\n";
}
```