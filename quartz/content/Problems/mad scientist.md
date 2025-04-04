# mad scientist
---
>[!summary] A weird [[Greedy]] algorithm usaco problem


# Explanation
---
This problem gives you two strings and asks you the minimum amount of operations required to turn string B into A, where the only thing you can do is flip the letters in any given substring.

This can be done in a [[Greedy]] fashion. Since we want to minimize the number of operations required, we need to maximize the substrings that we will be using to make the flips. 

The way we can do this is by simply going through and finding substrings where the characters in the string are different and flipping them. If we tried anything bigger, we'd be flipping characters that were already matching, which would cost another operation to fix. 

# Code
---
```cpp
void solve()
{
	freopen("breedflip.in","r",stdin);
	freopen("breedflip.out","w",stdout);
	int n; cin >> n; 
	string a,b; cin >> a >> b;

	vector<int> trans = {};
	if(b[0] != a[0]) trans.pb(1);

	for(int i = 1; i < n; i++)
	{
		if(b[i] != a[i] and b[i-1] == a[i-1])
		{
			trans.pb(1);
		}
		else if(b[i] != a[i]){
			trans.back()++;
		}
	}

	cout << trans.size() << "\n";

}
```