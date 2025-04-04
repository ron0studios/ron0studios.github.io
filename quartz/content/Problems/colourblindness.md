# colourblindness
---
>[!summary] easy CF problem


# Explanation
---
Basically you just treat all the `G's` as `B's` by converting them to see it through Vasya's eyes. This is just basic [[ad hoc]]

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<string> grid(2,"");
	cin >> grid[0];
	cin >> grid[1];

	for(int i = 0; i < n; i++)
		if(grid[0][i] == 'G') grid[0][i] = 'B';

	for(int i = 0; i < n; i++)
		if(grid[1][i] == 'G') grid[1][i] = 'B';

	if(grid[0] == grid[1])
	{
		cout << "YES\n";
	}
	else
	{
		cout << "NO\n";
	}
}
```