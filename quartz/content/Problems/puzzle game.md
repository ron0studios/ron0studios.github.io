#bio 
# Puzzle game
---
> BIO 2009 question 2


# Explanation
---
functions!
A [[matrix|grid]] based problem, involving a system similar to [[four in a line]]

# Code
---
```cpp

vector<vector<string>> grid;
vector<vector<string>> storage; 
vector<pair<int,int>> delta = {{1,0},{0,-1},{-1,0},{0,1}};
int points = 0;

bool ok(int a, int b) { return a >= 0 and b >= 0 and a < 4 and b < 4; } 

vector<pair<int,int>> blocksize(pair<int,int> pos)
{
	vector<pair<int,int>> out = {pos};
	string check = grid[pos.first][pos.second];

	queue<pair<int,int>> q; 
	map<pair<int,int>, bool> visited; 
	q.push(pos);
	visited[pos] = true;

	while(!q.empty())
	{
		auto x = q.front(); q.pop();
		
		for(auto i : delta)
		{
			pair<int,int> result = x + i;
			if(ok(result.first,result.second))
			{

				if(!visited[result] and grid[result.first][result.second] == check)
				{
					visited[result] = true; 
					q.push(result); 
					out.pb(result);
				}

			}
		}
	}

	return out;
}

void removeblocks()
{
	int product = 1;
	while(true)
	{
		bool breakout = false;
		for(int i = 0; i < 4; i++)
		{
			if(breakout) break;
			for(int j = 0; j < 4; j++)
			{
				if(grid[i][j] == " ") continue;
				if(breakout) break;
				vector<pair<int,int>> blocks = blocksize(mp(i,j));
				if(blocks.size() >= 2)
				{
					product *= blocks.size();
					for(auto k : blocks)
					{
						grid[k.first][k.second] = " ";
					}
					breakout = true;
				}
			}
		}
		if(breakout == false) break;
	}
	if(product != 1) points += product;
}

string pop_storage(int col)
{
	string out;
	for(int i = 500-1; i >= 0; i--)
	{
		if(storage[i][col] != "X")
		{
			out = storage[i][col];
			storage[i][col] = "X";
			break;
		}
	}
	return out;
}

void fall(){
	
	for(int i = 0; i < 4; i++)
	{
		vector<string> col; 
		vector<string> outcol;
		for(int j = 0; j < 4; j++)
		{
			col.push_back(grid[j][i]);
		}

		// push up airspace 
		int aircount = 0;
		for(auto j : col)
		{
			if(j == " ")
			{
				aircount++; 
			}
			else{
				outcol.pb(j);
			}
		}

		// fill in remaining air with storage
		vector<string> from_storage; 
		for(int j = 0; j < aircount; j++)
		{
			from_storage.pb(pop_storage(i));
		}
		outcol.insert(outcol.begin(),from_storage.rbegin(),from_storage.rend());

		/*for(auto j : outcol){
			cout << j << " ";
		}
		cout << "\n";*/
		
		// finish
		for(int j = 0; j < 4; j++)
		{
			grid[j][i] = outcol[j];
		}
	}

}

void solve(int tc)
{
	grid = vector<vector<string>>(4,vector<string>(4,""));
	points = 0;

	for(int i = 0; i < 4; i++)
	{
		vector<string> tmp;
		for(int j = 0; j < 4; j++)
		{
			char x; cin >> x; 
			tmp.push_back( string(1,x) );
		}
		grid[i] = tmp;
	}

	for(int tmp = 0; tmp < 125; tmp++)
	{
		for(int i = 0; i < 4; i++)
		{
			storage.pb(vector<string>());
			for(int j = 0; j < 4; j++)
			{
				storage.back().pb(grid[i][j]);
			}
		}
	}


	auto prevgrid = grid;
	while(true)
	{
		int x; cin >> x;
		if(x == 0)
		{
			return;
		}
		else
		{
			for(int i = 0; i < x; i++)
			{
				removeblocks(); fall();
			}

			if(grid == prevgrid) // no change has happened
			{
				cout << points << "\n\n";
				cout << "GAME OVER\n";
				return;
			}
			prevgrid = grid;

			for(auto i : grid)
			{
				for(auto j : i)
					cout << j;
				cout << "\n";
			}

			cout << points << "\n\n";

		}
	}

	removeblocks();
	fall();


}


```