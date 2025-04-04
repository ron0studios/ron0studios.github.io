# make takahashi happy
---
>[!summary] A fun atcoder problem


# Explanation
---
This algorithm runs on [[complete search]], with a bit of [[DFS]] to explore all possible paths using [[recursion]]. 

The blocked states were saved in a hashmap to avoid using the same number twice.

# Code
---
```cpp

int h, w;
vector<vector<int>> grid;

ll compute(int i=0, int j=0, unordered_map<int,bool> blocked=unordered_map<int,bool>(), int depth=0)
{
	if(i == h-1 and j == w-1) return 1;
	blocked[grid[i][j]] = true;

	ll tot = 0;
	if(j!=w-1)
	{
		ll right = grid[i][j+1];
		if(not blocked.count(right))
		{
			tot += compute(i,j+1, blocked, depth+1);
		}
	}
	if(i != h-1)
	{
		ll down = grid[i+1][j];
		if(not blocked.count(down))
		{
			tot += compute(i+1,j, blocked, depth+1);
		}
	}

	return tot;

}

void solve()
{
	cin >> h >> w;
	grid = vector<vector<int>>(h, vector<int>(w,0));
	for(int i = 0; i < h; i++)
		for(int j = 0; j < w; j++)
			cin >> grid[i][j];

	cout << compute();

}
```