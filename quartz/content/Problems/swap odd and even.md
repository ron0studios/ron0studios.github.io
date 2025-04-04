# swap odd and even
---
>[!summary] an atcoder problem


# Explanation
---
easy [[ad hoc]]

# Code
---
```cpp
void solve()
{
	string s; cin >> s;
	for(int i = 0; i < (int)s.length()-1; i+=2){
		swap(s[i],s[i+1]);
	}
	cout << s;
}
```