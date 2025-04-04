# Jumping Mario
---
>[!summary]  UVA 11764 - very easy problem (took 5 mins)


# Explanation
---
This is an [[ad hoc]] problem that simply requires two comparisons.

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n; n--;
	int h, l; h = l = 0;
	int pos; cin >> pos;
	while(n--)
	{
		int newpos; cin >> newpos; 
		if (newpos > pos) h++;
		if (newpos < pos) l++;
		pos = newpos;
	}
	cout << h << " " << l << endl;
}
```