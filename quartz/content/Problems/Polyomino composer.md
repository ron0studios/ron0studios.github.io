# Polyomino composer
---
>[!summary] UVA 12291. A moderate [[ad hoc]]/tedious problem. Took around 1 hour, but another 1 hour 30 minutes was spent debugging 😭


# Explanation
---
This problem is essentially a generalised version of [[pentominoes]], i.e involving N-ominoes instead of just 4. You create a [[matrix|grid]] *mask* for 2 copies of the smaller polyomino, and keep iterating through a larger grid until you find a match equal to the larger polyomino!  Note that you will need to "crop" both masks to make sure when you equate the larger polyomino with the smaller one, that they will both line up correctly. Refer to the `crop` function to see how this is done. 

> [!question] The debugging issue
> As I mentioned in the [[#Polyomino composer|summary]]^[that link was useless I just thought it looked cool 😭] I had made a nearly 99% complete solution to the problem in the first hour, but spent another 1 hour 30m debugging. **Why?**
> It was very odd. My code worked for every single UDebug test case^[over 600 in total!] but failed on the actual problem...
> It turns out that I forgot to make some very simple preliminary checks! The one in particular is whether the larger polyomino *contains **twice** as many squares as the smaller one*^[because having twice as many squares means that *two* of the smaller polyominos would be able to fit in the larger one!].
# Code
---
```cpp
bool ok(vector<int> x, int n, int m) {
	return x[0] < n and x[1] < m and x[0] >= 0 and x[1] >= 0;
}

vector<vector<int>> crop(vector<vector<int>> grid){
	int firstrow = -1;
	int firstcol = -1;
	int lastrow = -1;
	int lastcol = -1;

	for(int i = 0; i < (int)grid.size(); i++){
		for(int j = 0; j < (int)grid[0].size(); j++){
			if(grid[i][j] == 1){
				firstrow = i;
				break;
			}
		}
		if(firstrow > -1) break;
	}

	for(int i = 0; i < (int)grid[0].size(); i++){
		for(int j = 0; j < (int)grid.size(); j++){
			if(grid[j][i] == 1){
				firstcol = i;
				break;
			}
		}
		if(firstcol > -1) break;
	}


	for(int i = (int)grid.size()-1; i >= 0; i--){
		for(int j = 0; j < (int)grid[0].size(); j++){
			if(grid[i][j] == 1){
				lastrow = (int)grid.size()-i-1;
				break;
			}
		}
		if(lastrow > -1) break;
	}

	for(int i = (int)grid[0].size()-1; i >= 0; i--){
		for(int j = 0; j < (int)grid.size(); j++){
			if(grid[j][i] == 1){
				lastcol = (int)grid[0].size()-i-1;
				break;
			}
		}
		if(lastcol > -1) break;
	}

	while(firstrow--){
		grid.erase(grid.begin());
	}
	while(firstcol--){
		for(int i = 0; i < grid.size(); i++){
			grid[i].erase(grid[i].begin());
		}
	}
	
	while(lastrow--){
		grid.pop_back();
	}
	while(lastcol--){
		for(int i = 0; i < grid.size(); i++){
			grid[i].pop_back();
		}
	}
	

	return grid;
}

vector<vector<int>> deltify(vector<vector<int>> cropped){
	vector<vector<int>> out;
	for(int i = 0; i < (int)cropped.size(); i++){
		for(int j = 0; j < (int)cropped[0].size(); j++){
			if(cropped[i][j] == 1){
				out.pb({i,j});
			}
		}
	}
	return out;
}


void solve(int n, int m)
{
	vector<vector<int>> rawbig(n, vector<int>(n,0));
	vector<vector<int>> rawsmall(m, vector<int>(m,0));

	int countbig = 0;
	int countsmall = 0;

	for(int i = 0; i < n; i++){
		string s; cin >> s;
		stringstream ss(s);
		for(int j = 0; j < n; j++){
			char c; ss >> c;
			if(c=='*') {
				rawbig[i][j] = 1;
				countbig++;
			}
			else rawbig[i][j] = 0;
		}
	}

	for(int i = 0; i < m; i++){
		string s; cin >> s;
		stringstream ss(s);
		for(int j = 0; j < m; j++){
			char c; ss >> c;
			if(c=='*') {
				rawsmall[i][j] = 1;
				countsmall++;
			}
			else rawsmall[i][j] = 0;
		}
	}

	if(countbig != countsmall*2){
		cout << "0" << endl;
		return;
	}

	vector<vector<int>> cropbig = crop(rawbig);
	vector<vector<int>> cropsmall = crop(rawsmall);

	vector<vector<int>> deltbig = deltify(cropbig);
	vector<vector<int>> deltsmall = deltify(cropsmall);

	vector<vector<int>> grid(26, vector<int>(26, 0));

	for(int i = 0; i < (int)deltsmall.size(); i++){
		grid[12+deltsmall[i][0]][12+deltsmall[i][1]] = 1;
	}


	for(int i = 0; i < 26; i++){
		for(int j = 0; j < 26; j++){
			vector<vector<int>> outgrid = grid;
			bool fail = false;
			for(int k = 0; k < (int)deltsmall.size(); k++){
				vector<int> newpos = {i+deltsmall[k][0], j+deltsmall[k][1]};
				if(!ok(newpos, 26, 26) or grid[newpos[0]][newpos[1]] == 1){
					fail = true;
					break;
				}
				outgrid[newpos[0]][newpos[1]] = 1;
			}

			if(fail) continue;
			if(crop(outgrid) == cropbig){
				cout << "1" << endl;
				return;
			}
		}
	}

	cout << "0" << endl;
}
```