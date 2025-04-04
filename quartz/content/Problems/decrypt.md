# decrypt
---
>[!summary] Pretty easy BIO q1


# Explanation
---
This is a recursive problem, where you just substract from the previous index. 

> [!warning]
>  remember 1 based indexing!
# Code
---
```cpp
string decrypt(string a, int l)
{
	cout << a << endl;
	if(l == 0)
		return a;

	// +1 for 1-based indexing
	a[l] -= a[l-1] - 'A' +1;
	if(a[l] < 'A') a[l] = 'Z' - ('A' - a[l]) + 1;
	return decrypt(a,l-1);
}

void solve(int tc)
{
	string s; cin >> s;
	cout << decrypt(s, s.length()-1);
}

```