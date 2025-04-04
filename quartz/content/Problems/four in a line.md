#bio
# Four in a line
---
> Insanely time consuming BIO question 


# Explanation
---
- have a function that checks if there are 4 in a row, by doing 4 passes for vertical, horizontal and the 2 diagonals
- have a function to print the [[matrix|grid]]
- simulate


# Code
---
```cpp

int n = 6; int m = 7;

bool ok(int a, int b) {return a >= 0 and b >= 0 and a < n and b < m;}

	

bool is4(vector<vector<char>> grid) // is there a 4 in a row?
{
	// hori
	for(int i = 0; i < n; i++)
	{
		int c = 1;
		for(int j = 1; j < m; j++)
		{
			if(grid[i][j] != grid[i][j-1] or grid[i][j] == '-' or grid[i][j-1] == '-'){
				c = 1;
			}
			else{
				c++;
			}

			if(c==4){
				return true;
			}
		}
	}
	// vert
	for(int i = 0; i < m; i++)
	{
		int c = 1;
		for(int j = 1; j < n; j++)
		{
			if(grid[j][i] != grid[j-1][i] or grid[j][i] == '-' or grid[j-1][i] == '-')
			{
				c = 1;
			}
			else{
				c++;
			}

			if(c==4)
			{
				return true;
			}
		}
	}

	
	// diag \> 
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			vector<char> a; 
			for(int k = 0; k < 4; k++)
			{
				pair<int,int> loc = mp(i+k,j+k); 
				if(!ok(loc.first,loc.second)) 
					break;
				a.pb(grid[loc.first][loc.second]);
			}
			if(a.size() != 4) continue;

			bool different = false;
			for(int k = 1; k <a.size(); k++){
				if(a[k] != a[k-1] or a[k] == '-' or a[k-1] == '-'){
					different = true;
					break;
				}
			}
			if(different == false) return true; 
		}
	}

	// diag  </
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			vector<char> a; 
			for(int k = 0; k < 4; k++)
			{
				pair<int,int> loc = mp(i+k,j-k); 
				if(!ok(loc.first,loc.second)) 
					break;
				a.pb(grid[loc.first][loc.second]);
			}
			if(a.size() != 4) continue;

			bool different = false;
			for(int k = 1; k <a.size(); k++){
				if(a[k] != a[k-1] or a[k] == '-' or a[k-1] == '-'){
					different = true;
					break;
				}
			}
			if(different == false) return true; 
		}
	}

	return false;
}

pair<int,int> place(vector<vector<char>>& grid, int col, char s)
{
	for(int i = 1; i <= n; i++)
	{
		if(grid[n-i][col] == '-')
		{
			grid[n-i][col] = s;
			return mp(n-i,col);
		}
	}
	return mp(-999,-999); // bad
}

void printgrid(vector<vector<char>> grid)
{
	vector<char> symb = {'*','o'};
	for(auto i : grid)
	{
		for(auto j : i)
			cout << j;
		cout << "\n";
	}
	cout << "\n";
}

void solve(int tc)
{
	vector<vector<char>> grid(n,vector<char>(m,'-'));
	vector<pair<int,int>> delta = {{-1,0},{-1,1},{0,1},{1,1},{1,0},{1,-1},{0,-1},{-1,-1}};
	int n; cin >> n;
	vector<int> init; inveci(n,init);

	int turn = 0; // 0 = player 1, 1 = player 2
			 // player 1 = *  player 2 = o
	vector<char> symb = {'*','o'};

	for(auto i : init)
	{
		int idx = i-1;
		place(grid,idx, symb[turn]);
		turn = !turn;
	}
	printgrid(grid);

	while(true)
	{
		string inp; cin >> inp;
		if(inp == "n")
		{
			// simulate move

			// rule 1 (win)
			for(int i = 0; i < m; i++)
			{
				pair<int,int> placed = place(grid,i,symb[turn]);
				if(placed == mp(-999,-999)) continue;

				if(is4(grid)) 
				{
					cout << "Player " << turn+1 << " Wins\n";
					printgrid(grid);
					return;
				}
				else{
					grid[placed.first][placed.second] = '-';
				}
			}

			bool moved = false;
			// rule 2 (block)
			for(int i = 0; i < m; i++)
			{
				pair<int,int> placed = place(grid,i,symb[!turn]);
				if(placed == mp(-999,-999)) continue;
				if(is4(grid)) 
				{
					grid[placed.first][placed.second] = symb[turn];
					moved = true; break;
				}
				else{
					grid[placed.first][placed.second] = '-';
				}
			}

			// rule 3 (leftmost)
			if(!moved)
			{
				for(int i = 0; i < m; i++){
					pair<int,int> placed = place(grid,i,symb[turn]);
					if(placed == mp(-999,-999)) continue;
					break;
				}
			}

			turn = !turn;
			printgrid(grid);
		}
		else // r
		{
			while(true)
			{
				
				// rule 1 (win)
				for(int i = 0; i < m; i++)
				{
					pair<int,int> placed = place(grid,i,symb[turn]);
					if(placed == mp(-999,-999)) continue;

					if(is4(grid)) 
					{
						cout << "Player " << turn+1 << " Wins\n";
						printgrid(grid);
						return;
					}
					else{
						grid[placed.first][placed.second] = '-';
					}
				}

				bool moved = false;
				// rule 2 (block)
				for(int i = 0; i < m; i++)
				{
					pair<int,int> placed = place(grid,i,symb[!turn]);
					if(placed == mp(-999,-999)) continue;
					if(is4(grid)) 
					{
						grid[placed.first][placed.second] = symb[turn];
						moved = true; break;
					}
					else{
						grid[placed.first][placed.second] = '-';
					}
				}

				// rule 3 (leftmost)
				if(!moved)
				{
					for(int i = 0; i < m; i++){
						pair<int,int> placed = place(grid,i,symb[turn]);
						if(placed == mp(-999,-999)) continue;
						break;
					}
				}

				turn = !turn;
			}
		}
	}
}

```