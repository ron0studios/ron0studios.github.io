#bio
# down pat
---
> Pretty easy BIO 2021 Q1 [[ad hoc|implementation]]


# Explanation
---
This just requires some recursion and string manipulation

# Code
---
```cpp

bool pat(string inp)
{
	if(inp.length()==1)
		return true;
	
	
	for(int i = 1; i < inp.length(); i++)
	{
		string a,b; 
		a = inp.substr(0,i);
		b = string(inp.begin()+i,inp.end());
		reverse(a.begin(),a.end());
		reverse(b.begin(),b.end());
		//cout << a << " " << b << endl;
		if(*min_element(a.begin(),a.end()) <= *max_element(b.begin(),b.end()))
			continue;
		if(pat(a) and pat(b))
		{
			return true;
		}
	}
	return false;
}

void solve(int tc)
{
	string s1,s2;
	cin >> s1 >> s2;

	cout << pat(s1) << "\n";
	cout << pat(s2) << "\n";
	cout << pat(s1+s2) << "\n";
}


```