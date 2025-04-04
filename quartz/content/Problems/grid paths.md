# grid paths
---
>[!summary] cses hard problem

#tofinish
# Explanation
---
Used the pruning from CPH, but its slow (15 secs) because it used stl.

# Code
---
```cpp

#pragma GCC optimize("Ofast")
#pragma GCC target("avx2")

string path;
bool grid[7][7];
int cnt = 0;
vector<pair<int,int>> delta = {{-1,0},{0,1},{1,0},{0,-1}};
unordered_map<char,pair<int,int>> deltamap = {{'U',{-1,0}},{'R',{0,1}},{'D',{1,0}},{'L',{0,-1}}};
map<pair<int,int>,int> idxmap = {{{-1,0},0},{{0,1},1},{{1,0},2},{{0,-1},3}};

bool ok(int a, int b) { return a >= 0 and b >= 0 and a < 7 and b < 7 and grid[a][b] == 0;}


/*
void printgrid(pair<int,int> pos)
{
	vector<vector<int>> tmp = grid;
	tmp[pos.first][pos.second] = 9;
	for(auto i : tmp)
	{
		for(auto j : i)
			cout << j << " ";
		cout << "\n";
	}
	cout << "\n";
	cout << endl;
}
*/

void compute(pair<int,int> pos, int depth, pair<int,int> dir = mp(0,0))
{
	//cout << path[depth]  << " " << depth << " " << dir.first << ":" << dir.second <<"\n";
	//printgrid(pos);
	//usleep(1000000);
	if(depth == 48)
	{
		if(pos==mp(6,0)) cnt++;
		return;
	}

	if(pos == mp(6,0) and depth != 48){
		return;
	}


	pair<int,int> frontcheck = pos+dir;
	if(!ok(frontcheck.first, frontcheck.second)){
		int leftidx = idxmap[dir]-1; 
		if(leftidx < 0) leftidx = 3;
		pair<int,int> left = delta[leftidx] + pos;

		int rightidx = (idxmap[dir]+1) % 4; 
		pair<int,int> right = delta[rightidx] + pos;

		//cout << left.first<<":"<<left.second << " " << right.first<<":"<<right.second << "\n";
		if(ok(left.first,left.second) and ok(right.first, right.second))
		{
			//cout << "YUP!" << endl;
			return;
		}
	}

	
	if(path[depth] != '?')
	{
		pair<int,int> newpos = pos + deltamap[path[depth]];
		if(!ok(newpos.first,newpos.second))
			return;
		grid[pos.first][pos.second] = 1;
		compute(newpos,depth+1, deltamap[path[depth]]);
		grid[pos.first][pos.second] = 0;
		return;
	}

	for(auto i : delta)
	{
		pair<int,int> newpos = i+pos;
		if(ok(newpos.first, newpos.second))
		{
			grid[pos.first][pos.second] = 1;
			compute(newpos, depth+1, i);
			grid[pos.first][pos.second] = 0;
		}
	}
	
}

void solve()
{
	cin >> path; 
	cnt = 0;

	memset(grid,false,sizeof(grid));
	//grid = vector<vector<int>>(7,vector<int>(7,0));

	

	compute(mp(0,0), 0);

	cout << cnt << "\n";

}
```