# L-shapes
---
>[!summary] A hard codeforces implementation problem


# Explanation
---
This was a pretty twisty [[ad hoc|implementation]] problem, and tough to implement in under an hour (I had less than 10 seconds left!!!)

You use classic [[matrix|grid]] techniques and kerneling to find the L shapes. 

Edge detection was a nightmare, especially with the gap in the L shape (compared to a 2x2 square). This was solved by looping through the 12 outer squares outside the 2x2 which the L shape resides in and excluding the square which **doesn't** have an active square anywhere adjacent to it that also happens to be in the L-shape box. 

# Code
---
```cpp

int n, m;
bool ok(int a, int b) {return a >= 0 and b >=0 and a <n and b < m;}

vector<pair<int,int>> delta = {{0,1}, {1,1},{1,0},{1,-1},{0,-1}, {-1,-1},{-1,0},{-1,1}};

void solve(int tc)
{
	cin >> n >> m;

	vector<vector<int>> grid(n,vector<int>(m,0));
	for(int i = 0; i < n; i++)
	{
		string s; cin >> s;
		for(int j = 0; j < m; j++)
		{
			if(s[j] == '*')
			{
				grid[i][j] = 1;
			}
		}
	}

	// check for non-l shapes

	vector<vector<int>> tmp_grid = grid;
	for(int a = 0; a < n-1; a++)
	{
		for(int b = 0; b < m-1; b++)
		{
			int bA, bB, bC, bD; // box coord X
			bA = tmp_grid[a][b];
			bB = tmp_grid[a][b+1];
			bC = tmp_grid[a+1][b];
			bD = tmp_grid[a+1][b+1];

			// L
			if(bA+bB+bC+bD==3){
				tmp_grid[a][b] = 0;
				tmp_grid[a][b+1] = 0;
				tmp_grid[a+1][b] = 0;
				tmp_grid[a+1][b+1] = 0;
			}
		}
	}
	for(auto i : tmp_grid)
	{
		for(auto j : i)
		{
			if(j==1)
			{
				cout << "NO\n"; return;
			}
		}
	}
	// detect l shapes
	
	for(int a = 0; a < n-1; a++)
	{
		for(int b = 0; b < m-1; b++)
		{
			int bA, bB, bC, bD; // box coord X
			bA = grid[a][b];
			bB = grid[a][b+1];
			bC = grid[a+1][b];
			bD = grid[a+1][b+1];

			if(bA+bB+bC+bD==3) // L
			{
				pair<int,int> gap;
				// find gap
				if(bA != 1)
				{ 
					gap = mp(a,b);
				}
				else 
				if(bB != 1)
				{
					gap = mp(a,b+1);
				}
				else
				if(bC != 1)
				{
					gap = mp(a+1,b);
				}
				else
				if(bD != 1)
				{
					gap = mp(a+1,b+1);
				}

				vector<pair<int,int>> explore;
				for(int i = a-1; i <= a+2; i++)
				{

					for(int j = b-1; j <= b+2; j++)
					{
						pair<int,int> coord = mp(i,j);
						if(coord == mp(a,b) or coord == mp(a+1,b) or coord == mp(a,b+1) or coord == mp(a+1,b+1))
							continue;

						if(!ok(i,j)) continue;
						//if(abs(gap.first-i) == 1 and abs(gap.second-j) == 1) continue;


						if(grid[i][j] == 1)
						{
							bool doublecheck = false;
							for(auto p : delta)
							{
								pair<int,int> k = p + mp(i,j);
								if(!ok(k.first,k.second)) continue;
								if(grid[k.first][k.second] == 0) continue;
								if(k == mp(a,b) or k == mp(a+1,b) or k == mp(a,b+1) or k == mp(a+1,b+1))
								{
									doublecheck = true;
									break;
								}
							}
							if(doublecheck == false){
								continue;
							}
							cout << "NO\n";
							return;
						}
					}
				}

			}
		}
	}
	cout << "YES\n";
}


```