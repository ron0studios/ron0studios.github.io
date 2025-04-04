# papercuts 1
---
>[!summary] Fun/Annoying BIO 1998 R2 question


# Explanation
---
This is a pretty simple-ish [[recursion]] problem. The main hard part for this question was how coordinates were dealt with. 

### brief explanation
----
Essentially, we recurse through each possible horizontal cut we can make. We can confirm whether this cut is possible by checking whether either side of the cut contain different letters. If two letters on either side of the cut were the same, that means we'd be cutting a block in half, which is invalid. 
We then recurse for both sides of the cut horizontally too. 

Once we've reached a point at which no more horizontal cuts can be made in the recursion we do the same with vertical cuts this time. 

If, at any point, the given block contains all the same letters, we know we can stop. so that is our base case.

If there are no possible cuts, and there are different letter blocks, then we know we've hit a dead end, which is impossible. therefore we break out early and print out the statement.

# Code
---
```cpp

int m, n; 
string out = "";
bool impossible = false;

void compute(vector<vector<char>> grid, pair<int,int> offset = mp(0,0))
{
	if(impossible) return;
	if(grid.size() == 1 and grid[0].size() == 1) // only 1 element
		return;

	bool stop = false;
	char test = grid[0][0];
	for(auto i : grid){
		for(auto j : i)
			if(j != test){
				stop = true;
				break;
			}
		if(stop) break;
	}
	if(!stop) return;
	
	// horizontal cut
	for(int i = 0; i < grid.size()-1; i++)
	{
		bool skip = false;
		// see neighbours to check validity
		for(int j = 0; j < grid[i].size(); j++)
		{
			if(grid[i][j] == grid[i+1][j]){ 
				skip = true;
				break;
			}
		}

		if(!skip)
		{
			// go and check out the two sides of the cut
			vector<vector<char>> gridup, griddown; 
			gridup = vector<vector<char>>(grid.begin(), grid.begin()+i+1);
			griddown = vector<vector<char>>(grid.begin()+i+1, grid.end());


			stringstream ss;
			ss << "cut hori: ";
			ss << "(" << offset.second <<", " << n-(offset.first+i+1)  << ") ";
			ss << "(" << offset.second+grid[0].size() <<", " << n-(offset.first+i+1) << ")\n";
			out += ss.str();


			// gridup, no offset
			compute(gridup, offset );

			// griddown, offset of gridup length
			compute(griddown, offset+ mp((int)gridup.size(),0) );
			return;
		}
	}


	for(int i = 0; i < grid[0].size()-1; i++)
	{
		bool skip = false;

		for(int j = 0; j < grid.size(); j++)
		{
			if(grid[j][i] == grid[j][i+1])
			{
				skip = true;
				break;
			}
		}

		if(!skip)
		{
			vector<vector<char>> gridleft, gridright; 
			gridleft = gridright = grid;
			// trim off relevant parts
			for(auto& x : gridleft)
				x = vector<char>(x.begin(), x.begin()+i+1);
			for(auto& x : gridright)
				x = vector<char>(x.begin()+i+1, x.end());
				
			stringstream ss;
			ss << "cut vert: ";
			ss << "(" << offset.second+i+1 << ", " <<   n-(offset.first) << ") ";
			ss << "(" << offset.second+i+1  << ", " <<  n-(offset.first+grid.size()) << ")\n";
			out += ss.str();

			// gridleft, no offset
			compute(gridleft, offset);
			
			// gridright, offset of gridleft j-length
			compute(gridright, offset + mp(0, (int)gridleft[0].size()) );
			return;
		}
	}

	cout << "IMPOSSIBLE";
	impossible = true;

}

void solve(int tc)
{
	// n = vertical, m = horizontal
	cin >> m >> n;
 	vector<vector<char>> grid = vector<vector<char>>(n,vector<char>(m));
	out = "";
	impossible = false;

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			cin >> grid[i][j];
		}
	}
	compute(grid);
	if(!impossible) cout << out;
}


```