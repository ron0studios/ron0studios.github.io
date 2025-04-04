# I love 1543
---
>[!summary] Codeforces 2036 D. A finicky [[ad hoc]] [[matrix|grid]] problem. Took around 30 minutes


# Explanation
---
This problem has a similar approach to [[rotate matrix#my god awful solution 💀]], in that you need to break up a [[matrix|grid]] into multiple layers spanning from the middle. After that it is just a linear scan of the data to search for 1543.
# Code
---
```cpp
void solve(int tc)
{
	int n, m; cin >> n >> m;
	vector<vector<int>> grid(n, vector<int>(m));
	for(int i = 0; i < n; i++){
		string s; cin >> s;
		for(int j = 0; j < m; j++){
			grid[i][j] = s[j]-'0';
		}
	}

	vector<vector<int>> flat((int)ceil(n/2.0), vector<int>()); 
	for(int i = 0; i < ceil(n/2.0); i++){
		for(int j = i; j < m-i; j++){
			flat[i].pb(grid[i][j]);
		}

		for(int j = i+1; j < n-i; j++){
			flat[i].pb(grid[j][m-i-1]);
		}

		for(int j = m-i-2; j >= i; j--){
			flat[i].pb(grid[n-i-1][j]);
		}

		for(int j = n-i-2; j >= i+1; j--){
			flat[i].pb(grid[j][i]);
		}

	}


	int cnt = 0;
	vector<int> ans = {1,5,4,3};
	for(int i = 0; i < ceil(n/2.0); i++){
		for(int j = 0; j < flat[i].size(); j++){
			vector<int> check;
			for(int k = j; k < j+4; k++){
				int x = k%flat[i].size();
				check.pb(flat[i][x]);
			}

			if(check==ans)
				cnt++;
		}
	}

	cout << cnt << endl;

}
```