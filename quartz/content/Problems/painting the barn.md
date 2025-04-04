# painting the barn
---
>[!summary] 
> A pretty difficult USACO silver problem (feb 2019 Q2)


# Explanation
---
This problem requires a thorough knowledge of [[inverse prefix sum#2D inverse prefix sum|2D inverse prefix sums]]. 
Essentially you, use the inverse prefix sum and proceed to fill in the grid and then just count the number of indexes with value $k$

> [!notes] 
> The reason why the prefix grid has a size of **1002** instead of **1000** is because:
> - we need to pad the beginning of the grid with zeroes so that we don't get *out of bounds* errors.
> - `i` and `j` can both be 1000 **inclusive**, meaning we need an extra coordinate for when that is the case
> 
# Code
---
```cpp

void solve()
{
	freopen("paintbarn.in", "r", stdin);
	freopen("paintbarn.out", "w", stdout);
	int n, k; cin >> n >> k; // input

	vector<vector<ll>> grid(1002,vector<ll>(1002,0));
	for(int i = 0; i < n; i ++)
	{
		int x1,y1,x2,y2;
		cin >> x1 >> y1 >> x2 >> y2;
		grid[x1+1][y1+1]++;
		grid[x1+1][y2+1]--;
		grid[x2+1][y2+1]++;
		grid[x2+1][y1+1]--;
	}


	int kcount = 0;
	for(int i = 1; i <= 1001; i++)
	{
		for(int j = 1; j <= 1001; j++){
			grid[i][j] = grid[i-1][j] + grid[i][j-1] + grid[i][j] - grid[i-1][j-1];
			if(grid[i][j]==k)
				kcount++;
		}
	}
	cout << kcount;
}


```