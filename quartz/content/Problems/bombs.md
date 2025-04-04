# bombs
---
>[!summary] Atcoder problem


# Explanation
---
A simpleish [[ad hoc|implementation]] problem. You just have to be able to remember the manhattan distance formula (which is already in the problem statement)

# Code
---
```cpp
void solve()
{
	int r, c; cin >> r >> c;
	vector<vector<char>> grid(r, vector<char>(c, '1'));

	vector<pair<pair<int,int>,int>> bombs;
	for(int i = 0; i < r; i++)
	{
		for(int j =0; j < c; j++)
		{
			cin >> grid[i][j];
			if(isdigit(grid[i][j]))
			{
				bombs.pb(mp(mp(grid[i][j]-'0',i),j));
			}
		}
	}


	for(auto b : bombs)
	{
		int power = b.first.first;
		for(int i = 0; i < r; i ++)
		{
			for(int j = 0; j < c; j++)
			{
				int dist = abs(i-b.first.second) + abs(j-b.second);
				if(dist <= power){
					grid[i][j] = '.';
				}
			}
		}
	}
	
	for(int i = 0; i < r; i ++)
	{
		for(int j = 0; j < c; j++)
		{
			cout << grid[i][j];
		}
		cout << endl;
	}
}
```