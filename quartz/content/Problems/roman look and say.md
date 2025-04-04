#bio
# roman look and say
---
> A pretty hard BIO 2020 Q1 [[ad hoc|implementation]]


# Explanation
---
This problem is solved using simple [[dynamic programming]], however it was not necessary. Since I used strings instead of just counting the letters at each step, the program was slower, hence DP was necessary on the `num2roman` function.

some [[string]] manipulation knowledge is needed.

# Code
---
```cpp


unordered_map<int,string> dp; 
string num2roman(int inp)
{
	int oginp = inp;
	if(dp.contains(inp)){
		return dp[inp];
	}

	string out = "";
	while(true)
	{
		vector<string> tokens = {"M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"};
		vector<int>    values = {1000,900,500,400,100,90,50,40,10,9,5,4,1};
		if(inp == 0) break;
		for(int i = 0; i < 13; i++)
		{
			if(values[i] <= inp)
			{
				out += tokens[i];
				inp -= values[i];
				break;
			}
		}
	}

	dp[oginp] = out;
	return out;
}


string lookandsay(string s)
{
	vector<string> tokens;
	tokens.pb(string(1,s[0]));
	for(int i = 1; i < s.size(); i++)
	{
		if(s[i] == tokens.back()[0])
		{
			tokens.back() += s[i];
		}
		else
		{
			tokens.pb(string(1,s[i]));
		}
	}

	string out = "";

	for(auto i : tokens)
	{
		out += num2roman(i.length())+i[0];
	}
	return out;
}

void solve(int tc)
{
	string s; cin >> s;
	int n; cin >> n;

	string out = s;
	for(int i = 0; i < n; i++)
	{
		out = lookandsay(out);
	}
	cout << count(out.begin(),out.end(),'I') << " " << count(out.begin(),out.end(),'V') << "\n";
}
```