# santa claus 1
---
>[!summary] ABC 385 B. Simple [[matrix|grid]] [[ad hoc]] problem. took around 15 mins


# Explanation
---
Just a simulation problem. very similar to [[drats]]. Remember to check for out-of-bounds conditions and **include** the starting position as a potential present.
# Code
---
```cpp
bool ok(int x, int y, int n, int m){
	return x >= 0 and y >= 0 and x < n and y < m;
}

void solve()
{
	int n,m; cin >> n >> m;
	int x,y; cin >> x >> y;
	x--; y--;

	vector<vector<int>> grid(n, vector<int>(m,0));
	for(int i = 0; i < n; i++){
		for(int j = 0;j < m; j++){
			char k; cin >> k;
			if(k == '#') {
				grid[i][j] = 2;
			} else if(k=='@') {
				grid[i][j] = 1;
			} else grid[i][j] = 0;
		}
	}

	string steps; cin >> steps;
	pair<int,int> pos = mp(x,y);
	set<pair<int,int>> presents;
	if(grid[x][y] == 1) presents.insert(mp(x,y));
	unordered_map<char,pair<int,int>> dirs;
	dirs['U'] = mp(-1,0);
	dirs['D'] = mp(1,0);
	dirs['L'] = mp(0,-1);
	dirs['R'] = mp(0,1);
	for(int i = 0; i < steps.size(); i++){
		pair<int,int> npos = pos+dirs[steps[i]];
		if(!ok(npos.first, npos.second, n,m)) continue;
		if(grid[npos.first][npos.second] == 2) continue;
		pos = npos;
		if(grid[pos.first][pos.second] == 1){
			presents.insert(pos);
		}
	}

	cout << pos.first+1 << " " << pos.second+1 << " " << presents.size() << endl;
}
```