# socks
---
>[!summary] A pretty simple Atcoder problem


# Explanation
---
This problem is a simple [[Greedy]] problem. Just do some counting and floor divide. 

> [!warning]
In the actual contest, I flopped this problem because i accidentally wrote `map<char,int> pairs` instead of `map<int,int> pairs` as a typo from doing the previous question [[bombs]]. Since **chars** and **ints** are treated almost the same in the range of ascii values for a char (probably 256?), all the base testcases worked fine. 

# Code
---
```cpp

void solve()
{
	int n; cin >> n;
	vector<int> socks(n,0);
	for(int i =0; i< n; i++)
		cin >> socks[i];

	map<int,int> pairs;
	for(auto i : socks)
		pairs[i]++;
		
	int out = 0;
	for(auto i : pairs)
	{
		out += (int)floor((float)i.second/2.0f); 
	}
	cout << out;
}
```