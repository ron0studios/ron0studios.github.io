#bio
# Ants - BIO2000 q2
---
> very weird [[ad hoc|implementation]] problem, same difficulty as [[battleships]]


# Explanation
---
its just simulation. First time using the new grid method from codeforces.

# Code
---
```cpp

void solve(int tc)
{
	vector<vector<int>> grid(11,vector<int>(11,0)); 
	vector<pair<int,int>> delta = { {0,1} ,{1,0} ,{0,-1} ,{-1,0} }; // T R B L
	
	pair<int,int> ant1coords;
	char ant1dir;
	bool ant1removed = false;

	pair<int,int> ant2coords;
	char ant2dir;
	bool ant2removed = false;

	map<char,pair<int,int>> dirmap; dirmap['T']={0,1}; dirmap['R']={1,0}; dirmap['B']={0,-1}; dirmap['L']={-1,0}; 
	vector<char> dirs = {'T','R','B','L'};

	cin >> ant1coords.first >> ant1coords.second >> ant1dir; 
	cin >> ant2coords.first >> ant2coords.second >> ant2dir;

	while(true)
	{
		int x; cin >> x;

		//cout << x << endl;
		if(x == -1) return;

		for(int i = 0; i < x; i++)
		{
			if(not ant1removed){
				// simulate ant 1
				ant1coords = ant1coords +  dirmap[ant1dir];
				if(not ok(ant1coords.first, ant1coords.second) ) 
				{
					ant1removed = true;
				}
				else
				{
					if(grid[ant1coords.first][ant1coords.second] == 0)
					{
						grid[ant1coords.first][ant1coords.second] = 1;
						char next = ((find(dirs.begin(),dirs.end(),ant1dir)-dirs.begin())+1) % 4;
						ant1dir = dirs[next];
					}
					else // 1
					{
						grid[ant1coords.first][ant1coords.second] = 0;
						char next = (find(dirs.begin(),dirs.end(),ant1dir)-dirs.begin())-1;
						if(next==-1) next = 3; // because weird modulo
						ant1dir = dirs[next];
					}
				}
			}

			if(not ant2removed){
				// simulate ant 2
				ant2coords = ant2coords +  dirmap[ant2dir];
				if(not ok(ant2coords.first, ant2coords.second) ) 
				{
					ant2removed = true;
				}
				else
				{
					if(grid[ant2coords.first][ant2coords.second] == 0)
					{
						grid[ant2coords.first][ant2coords.second] = 1;
						char next = ((find(dirs.begin(),dirs.end(),ant2dir)-dirs.begin())+1) % 4;
						ant2dir = dirs[next];
					}
					else // 1
					{
						grid[ant2coords.first][ant2coords.second] = 0;
						char next = (find(dirs.begin(),dirs.end(),ant2dir)-dirs.begin())-1;
						if(next==-1) next = 3; // because weird modulo
						ant2dir = dirs[next];
					}
				}
			}
		}

		for(int i = 10; i >= 0; i--)
		{
			for(int j = 0; j < 11; j++)
				cout << ((grid[j][i]) ? "*" : ".");
			cout << "\n";
		}
		if(ant1removed)
			cout << "removed\n";
		else
			cout << ant1coords.first << " " << ant1coords.second << ant1dir << "\n";

		if(ant2removed)
			cout << "removed\n";
		else
			cout << ant2coords.first << " " << ant2coords.second << ant2dir << "\n";
	}



}


```