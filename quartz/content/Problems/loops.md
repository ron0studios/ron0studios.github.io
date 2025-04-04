#bio
# loops
---
>[!summary] Hard BIO Q2 problem from 2014


# Explanation
---
This is a difficult [[ad hoc]] problem which requires a lot of manual hard coding ( i think atleast) .

Essentially you first have to manually create 2 graphs from the grid input, one for the dotted lines and another for the bold lines. 

You then run a recursive function to traverse each loop for each cell on the grid. The way it works is that we'll maintain a visited grid, to check whats been visited at each cell, the bold, the dotted or even both. This is stored as an integer, and accessed using [[bitwise operations]]. 

Now for the traversal:
- We will do this [[recursion|recursively]].
- We check whether any of the graph nodes have already been visited when traversing, and if this is the case we return -1.
- The exception to the above rule is if the node that's already been visited is the origin, in which case we will have made a complete loop and return `dist`. 
- Alongside `origin` and `pos`, we also maintain a `prev`  coordinate, which will store the last traversed node in the recursion.
- We check each of the neighbouring edges, and only traverse the edge that doesn't go back into the `prev` node, hence only exploring the next node in the path and not going back in on itself.
- We also set any nodes to visited in the meantime too.

We add the logic to check whether its visited, so we avoid awarding points to the same loop twice.

# Code
---
```cpp

class Loops {
	public:
		vector<vector<int>> grid;
		int gridsize;

		map<pair<int,int>, vector<pair<int,int>> > graph_dotted;
		map<pair<int,int>, vector<pair<int,int>> > graph_bold;
		vector<vector<int>> visited;
		int p_bold = 0;
		int p_dotted = 0;

		Loops(int n, vector<vector<int>> grid)
		{
			this->gridsize = n;
			this->grid = grid;
			visited = vector<vector<int>>(n,vector<int>(n,0));

			// generate graph;
			for(int i = 0; i < n; i++)
			{
				for(int j = 0; j < n; j++)
				{
					switch(grid[i][j])
					{
						case 1:
							if(ok(i-1,j)) {
								if(grid[i-1][j] < 2 or grid[i-1][j] > 4) graph_bold[mp(i,j)].pb(mp(i-1,j));
							}
							if(ok(i+1,j)) {
								if(grid[i+1][j] == 1 or grid[i+1][j] == 3 or grid[i+1][j] == 4) graph_bold[mp(i,j)].pb(mp(i+1,j));
							}
							if(ok(i,j-1)) {
								if(grid[i][j-1] == 1 or grid[i][j-1] == 3 or grid[i][j-1] == 6) graph_dotted[mp(i,j)].pb(mp(i,j-1));
							}
							if(ok(i,j+1)) {
								if(grid[i][j+1] == 1 or grid[i][j+1] == 4 or grid[i][j+1] == 5) graph_dotted[mp(i,j)].pb(mp(i,j+1));
							}

							break;
						case 2:
							if(ok(i-1,j)) {
								if(grid[i-1][j] >= 2 or grid[i-1][j] <= 4) graph_dotted[mp(i,j)].pb(mp(i-1,j));
							}
							if(ok(i+1,j)) {
								if(grid[i+1][j] == 2 or grid[i+1][j] == 5 or grid[i+1][j] == 6) graph_dotted[mp(i,j)].pb(mp(i+1,j));
							}
							if(ok(i,j-1)) {
								if(grid[i][j-1] == 2 or grid[i][j-1] == 4 or grid[i][j-1] == 5) graph_bold[mp(i,j)].pb(mp(i,j-1));
							}
							if(ok(i,j+1)) {
								if(grid[i][j+1] == 2 or grid[i][j+1] == 3 or grid[i][j+1] == 6) graph_bold[mp(i,j)].pb(mp(i,j+1));
							}

							break;
						case 3:
							if(ok(i-1,j)) {
								if(grid[i-1][j] < 2 or grid[i-1][j] > 4) graph_bold[mp(i,j)].pb(mp(i-1,j));
							}
							if(ok(i+1,j)) {
								if(grid[i+1][j] == 2 or grid[i+1][j] == 5 or grid[i+1][j] == 6) graph_dotted[mp(i,j)].pb(mp(i+1,j));
							}
							if(ok(i,j-1)) {
								if(grid[i][j-1] == 2 or grid[i][j-1] == 4 or grid[i][j-1] == 5) graph_bold[mp(i,j)].pb(mp(i,j-1));
							}
							if(ok(i,j+1)) {
								if(grid[i][j+1] == 1 or grid[i][j+1] == 4 or grid[i][j+1] == 5) graph_dotted[mp(i,j)].pb(mp(i,j+1));
							}
							break;
						case 4:
							if(ok(i-1,j)) {
								if(grid[i-1][j] < 2 or grid[i-1][j] > 4) graph_bold[mp(i,j)].pb(mp(i-1,j));
							}
							if(ok(i+1,j)) {
								if(grid[i+1][j] == 2 or grid[i+1][j] == 5 or grid[i+1][j] == 6) graph_dotted[mp(i,j)].pb(mp(i+1,j));
							}
							if(ok(i,j-1)) {
								if(grid[i][j-1] == 1 or grid[i][j-1] == 3 or grid[i][j-1] == 6) graph_dotted[mp(i,j)].pb(mp(i,j-1));
							}
							if(ok(i,j+1)) {
								if(grid[i][j+1] == 2 or grid[i][j+1] == 3 or grid[i][j+1] == 6) graph_bold[mp(i,j)].pb(mp(i,j+1));
							}
							break;
						case 5:
							if(ok(i-1,j)) {
								if(grid[i-1][j] >= 2 or grid[i-1][j] <= 4) graph_dotted[mp(i,j)].pb(mp(i-1,j));
							}
							if(ok(i+1,j)) {
								if(grid[i+1][j] == 1 or grid[i+1][j] == 3 or grid[i+1][j] == 4) graph_bold[mp(i,j)].pb(mp(i+1,j));
							}
							if(ok(i,j-1)) {
								if(grid[i][j-1] == 1 or grid[i][j-1] == 3 or grid[i][j-1] == 6) graph_dotted[mp(i,j)].pb(mp(i,j-1));
							}
							if(ok(i,j+1)) {
								if(grid[i][j+1] == 2 or grid[i][j+1] == 3 or grid[i][j+1] == 6) graph_bold[mp(i,j)].pb(mp(i,j+1));
							}
							break;
						case 6:
							if(ok(i-1,j)) {
								if(grid[i-1][j] >= 2 or grid[i-1][j] <= 4) graph_dotted[mp(i,j)].pb(mp(i-1,j));
							}
							if(ok(i+1,j)) {
								if(grid[i+1][j] == 1 or grid[i+1][j] == 3 or grid[i+1][j] == 4) graph_bold[mp(i,j)].pb(mp(i+1,j));
							}
							if(ok(i,j-1)) {
								if(grid[i][j-1] == 2 or grid[i][j-1] == 4 or grid[i][j-1] == 5) graph_bold[mp(i,j)].pb(mp(i,j-1));
							}
							if(ok(i,j+1)) {
								if(grid[i][j+1] == 1 or grid[i][j+1] == 4 or grid[i][j+1] == 5) graph_dotted[mp(i,j)].pb(mp(i,j+1));
							}
							break;
					}

				}
			}
		}

		void run()
		{
			for(int i = 0; i < gridsize; i++)
			{
				for(int j = 0; j < gridsize; j++)
				{
					// traverse bold
					if(visited[i][j] % 2 == 0)
					{
						int score = traverse(mp(i,j), mp(i,j), 0);
						if(score != -1)
						{
							p_bold += score;
						}
					}

					// traverse dotted
					if((visited[i][j] >> 1) % 2 == 0)
					{
						int score = traverse(mp(i,j), mp(i,j), 1);
						if(score != -1)
						{
							p_dotted += score;
						}
					}
				}
			}
		}

		int traverse(pair<int,int> pos, pair<int,int> origin, int mode, int dist=0, pair<int,int> prev=mp(-1,-1))
		{
			if(pos == origin and (visited[pos.first][pos.second] >> mode) % 2) return dist;
			if((visited[pos.first][pos.second] >> mode) % 2) return -1;


			visited[pos.first][pos.second] = visited[pos.first][pos.second] | (1 << mode);
			if(mode == 1)
			{
				for(auto i : graph_dotted[pos])
				{
					if(i == prev) continue;
					return traverse(i, origin, mode, dist+1, pos);
				}
			}
			else
			{
				for(auto i : graph_bold[pos])
				{
					if(i==prev) continue;
					return traverse(i, origin, mode, dist+1, pos);
				}
			}

			return -1;
		}

	private:
		bool ok(int a, int b) {
			return a >= 0 and b >= 0 and a < gridsize and b < gridsize;
		}
};

void solve()
{
	int n; cin >> n;
	vector<vector<int>> grid(n, vector<int>(n,0));

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
		{
			cin >> grid[i][j];
		}
	}

	Loops loops(n, grid);
	loops.run();
	cout << loops.p_bold << " " << loops.p_dotted << endl;


}


```
