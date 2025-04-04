# insert digit
---
>[!summary] Relatively simple codeforces problem


# Explanation
---
This problem requires a bit of [[maths]], but is generaly just a [[Greedy]] problem. 

All you have to do is find the first digit that's less than the digit that you're trying to insert. Since this digit will have a higher numerical order at that position, we insert it there.

# Code
---
```cpp
void solve(int tc)
{
	int n, d; cin >> n >> d;
	string s; cin >> s;
	for(int i = 0; i < n; i++)
		if(s[i]-'0' < d)
		{
			cout << string(s.begin(), s.begin()+i) + string(1,'0'+d) + string(s.begin()+i, s.end()) << endl;
			return;
		}

	cout << s + string(1, '0'+d) << endl;
}
```