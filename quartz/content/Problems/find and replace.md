# find and replace
---
>[!summary] fun codeforces easy problem


# Explanation
---
This is a simple [[Greedy]] problem. The main observation here is that the difference between every occurence of every letter must be even.^[if it was odd, then there would be an even number of numbers between the two, and therefore it would be impossible to have alternating 1's and 0's.]

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	string s; cin >> s;

	unordered_map<char,int> chars;
	for(int i = 0; i < (int)s.length(); i++){
		if(chars.count(s[i])){
			if((i-chars[s[i]]) % 2){
				cout << "NO\n"; return;}
		}
		chars[s[i]] = i;
	}
	cout << "YES\n";
}
```