# minesweeper
---
>[!summary] UVA 10189. A fairly easy problem made complicated by the UVA judge being overly strict with their input. I finished the actual problem in ~10-15 minutes but dealing with the line restrictions took up to ~30 minutes


# Explanation
---
This is an [[ad hoc]] [[matrix|grid]] game implementation requiring delta values, to count the number of adjacent cells that have a mine in it, where i use `-1` as the representation of a mine.
The variable `coutendl` is used so i can print a line gap between each test case since the judge was being very strict about this. The neighbour checking system is similar to the boundary checking of [[L-shapes]].

# Code
---
```cpp
bool ok(int x, int y, int n, int m){
	return x >= 0 and y >= 0 and x < n and y < m;
}

void solve(int n, int m, int tc)
{
	vector<vector<int>> mines(n, vector<int>(m, 0));
	for(int i =0; i < n; i++)
	{
		for(int j = 0;j < m; j++)
		{
			char x; cin >> x;
			switch(x)
			{
				case '.':
					mines[i][j] = 0;
					break;
				case '*':
					mines[i][j] = -1;
			}
		}
	}

	vector<vector<int>> delta = {{1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1}, {-1,0}, {-1,1}, {0,1}};

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			if(mines[i][j] == -1) continue;
			for(auto k : delta)
			{
				vector<int> pos = {k[0] + i, k[1] + j};
				if(!ok(pos[0], pos[1], n, m)) continue;
				if(mines[pos[0]][pos[1]] == -1)
				{
					mines[i][j] ++;
				}
			}
		}
	}



	cout << "Field #" << tc << ":" << endl;
	for(int i =0 ; i < n; i++)
	{
		for(int j =0 ; j< m; j++)
		{
			if(mines[i][j] == -1)
			{
				cout << "*";
			}
			else cout << mines[i][j];
		}

		cout << endl;
	}
}

int main()
{
    ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0);
	int a,b;
	int tc = 1;
	bool coutendl = false;
    while(cin >> a >> b)
    {
		if(a == 0 and b == 0) break;
		if(coutendl) cout << endl;
        solve(a,b, tc);
		tc++;
		coutendl = true;
    }
    return 0;
}
```