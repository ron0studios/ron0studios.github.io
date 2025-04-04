#bio
# Rules
---
> A hard BIO problem from 2006 q2


# Explanation
---
There is [[dynamic programming]] in use when recursing the possible rules, it helps reduce the computing time to 4 seconds in the worst possible case. Recursion in the comb function is also limited using the min_len() function, which stops recursion if the length is greater than 12^[the max length of string 1 or 2]. 
A [[parsing|parser]] function breaks the rules into chunks, and the comb function returns all possible combinations of rules applicable.
the resultant combinations are filtered to the ones that are the length of the [[string]] and they are then read to check if they match in the compatible() function. 
The dp object in question is actually a [[hash map]] since we need to be able to map two very different data structures together

# Code
---
```cpp

map<vector<pair<string,int>>, vector<string>> dp; 

vector<pair<string,int>> parse(string raw){
	vector<pair<string,int>> pieces;
	string tmp = "";

	// 0 = once, 1 = ?, 2 = * 
	for(int i = 0; i < raw.length(); i++)
	{
		if(raw[i] != '(' and raw[i] != '*' and raw[i] != '?')
		{
			tmp += raw[i]; 
		}
		else if(raw[i] == '*' or raw[i] == '?')
		{
			if(tmp.length() > 1)
			pieces.pb(mp(string(tmp.begin(),tmp.end()-1),0));
			tmp = "";
			if(raw[i] == '*')
			{
				pieces.pb(mp(string(1,raw[i-1]),2));
			}
			else
			{
				pieces.pb(mp(string(1,raw[i-1]),1));
			}
		}
		else
		{ 
			pieces.pb(mp(tmp,0)); 
			tmp = ""; 

			string bracket; 
			char symb; 
			for(int j = i+1; j < raw.length(); j++)
			{
				if(raw[j] == ')') {symb = raw[j+1]; i=j+1; break; }
				bracket += raw[j]; 
			}
			if(symb=='?') pieces.pb(mp(bracket,1));
			if(symb=='*') pieces.pb(mp(bracket,2));
		}
	}
	if(tmp!="") pieces.pb(mp(tmp,0)); 

	return pieces;
}

int min_len(vector<pair<string,int>> parsed)
{
	int out= 0; 
	for(auto i : parsed)
	{
		if(i.second==0)
			out += i.first.length();
	}
	return out;
}

vector<string> comb(vector<pair<string,int>> parsed)
{
	//cout << dp[parsed].size() << endl;  
	if(!dp[parsed].empty()){
		return dp[parsed]; 
	}

	vector<string> out;
	// check for no * or ? 
	bool symbols = false;
	for(auto i : parsed)
		if(i.second != 0) 
			symbols = true;
	if(!symbols){
		out.pb("");
		for(auto i : parsed) {
			out.back() += i.first; 
		}
		return out;
	}

	for(int i = 0; i < parsed.size(); i++)
	{
		if(parsed[i].second==1) // ? 
		{
			vector<pair<string,int>> with = parsed;
			vector<pair<string,int>> without = parsed;
			without.erase(without.begin()+i); 
			with[i].second = 0; // convert from (xx)? to xx
			
			vector<vector<string>> possibilities = {
				comb(with), comb(without)
			};
			out.insert(out.begin(), possibilities[0].begin(),possibilities[0].end());
			out.insert(out.begin(), possibilities[1].begin(),possibilities[1].end());
		}
		else if(parsed[i].second==2) // *
		{
			vector<pair<string,int>> without = parsed;
			without.erase(without.begin()+i); 

			vector<pair<string,int>> with = parsed;
			with[i].second = 0; // convert from (xx)* to xx
			for(int j = 0; j<=12; j++) // worst case scenario
			{
				if(min_len(with) > 12)
					continue;
				vector<string> x = comb(with); 
				out.insert(out.begin(),x.begin(),x.end());
				with.insert(with.begin()+i,with[i]); 
			}
		}
	}

	dp[parsed] = out;
	return out;
}

// assumes both are same length and also that rule 1 is always x
bool compatible(string s, string rule)
{
	for(int i = 1; i < rule.length(); i++)
	{
		if(rule[i] == 'u') {
			if(s[i]-'0' <= s[i-1]-'0') return false;
		}
		else if(rule[i] == 'd')
		{
			if(s[i]-'0' >= s[i-1]-'0') return false;
		}
	}
	return true; 
}

// rules
void solve(int tc)
{
	string raw_rule; cin >> raw_rule;
	string p1, p2; cin >> p1 >> p2; 
	vector<pair<string,int>> parsed = parse(raw_rule);
	dp.clear();
	vector<string> options = comb(parsed);

	string out1 = "no";
	string out2 = "no";
	for(auto i : options)
	{
		if(i.length() == p1.length())
		{
			if(compatible(p1,i))
				out1 = "yes";
		}
		if(i.length() == p2.length())
		{
			if(compatible(p2,i))
				out2 = "yes";
		}
	}
	cout << out1 << "\n" << out2 << "\n";
}


```