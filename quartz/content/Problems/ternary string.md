# ternary string
---
>[!summary] Hard to spot codeforces problem


# Explanation
---
This probably has some kind of [[two pointers method]] solution, but this one was the one i ~~looked up~~ did.

every solution in this problem is in the form: $$\LARGE{ABB...BBC}$$
where $\large{(A,B,C)}$  interchangeably represent a permutation of $\large{(1,2,3)}$. Try and intuitively find out why this is the case.

You then 'blockify' the string into pairs of `(value, length)`, where value is either 1,2, or 3, and length is the number of contiguous occurences in that block. You can then do a simple linear scan and find the minimum needed.

# Code
---
```cpp
void solve(int tc)
{
	string s; cin >> s;
	vector<pair<int,int>> count;
	count.pb(mp(s[0]-'0',1));
	for(int i = 1; i < (int)s.length(); i++)
	{
		if(s[i] == s[i-1])
		{
			count.back().second++;
		}
		else
		{
			count.pb(mp(s[i]-'0',1));
		}
	}

	int minlen = INT_MAX;
	for(int i = 1; i < (int)count.size()-1; i++)
	{
		if(count[i].first != count[i-1].first and count[i].first != count[i+1].first and count[i+1].first != count[i-1].first)
		{
			minlen = min(minlen, count[i].second + 2);
		}
	}

	if(minlen == INT_MAX)
	{
		cout << 0 << endl;
	}
	else
	{
		cout << minlen << endl;
	}

}
```