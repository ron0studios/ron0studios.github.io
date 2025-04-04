# Word
https://codeforces.com/problemset/problem/59/A
## Code
```c++
void solve(int tc)
{
	string s; cin >> s;
	unordered_map<int,int> count;
	for(auto i : s)
		if(i<97) //small
			count[1]++;
		else
			count[0]++;
	if(count[1] <= count[0])
		for(auto i : s) cout << char(tolower(i));
	else
		for(auto i : s) cout << char(toupper(i));
}
```
