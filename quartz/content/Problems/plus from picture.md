# plus from picture
---
>[!summary] Hard codeforces problem


# Explanation
---
This is a pretty tedious [[ad hoc|implementation]] problem, similar to [[L-shapes]] and [[battleships]] in its masking to find neighbouring cells. 


# Code
---

```cpp
int n, m;
vector<vector<int>> grid; 

bool ok(int a, int b) {return a >= 0 and b >= 0 and a < n and b < m;}


vector<vector<int>> crossout(int a, int b, int& cnt )
{
	vector<vector<int>> out = grid;
	out[a][b] = 0;
	cnt--;

	vector<bool> pass(4,true);
	for(int i = 1; i < m+n; i++) {
		if(!pass[1] and !pass[2] and !pass[3] and !pass[0]) return out;
		if(ok(a+i,b) and pass[0])
		{
			if(out[a+i][b] == 0) {pass[0] = false;cnt++;}
			out[a+i][b] = 0; cnt--;
		}
		if(ok(a-i,b) and pass[1])
		{
			if(out[a-i][b] == 0) {pass[1] = false;cnt++;}
			out[a-i][b] = 0; cnt--;
		}
		if(ok(a,b+i) and pass[2])
		{
			if(out[a][b+i] == 0) {pass[2] = false;cnt++;}
			out[a][b+i] = 0; cnt--;
		}
		if(ok(a,b-i) and pass[3])
		{
			if(out[a][b-i] == 0) {pass[3] = false;cnt++;}
			out[a][b-i] = 0; cnt--;
		}
	}

	return out;
}

void solve()
{
	cin >> n >> m;
	grid = vector<vector<int>>(n, vector<int>(m,0));
	int cnt = 0;
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			char x; cin >> x;
			if(x == '*') {
				grid[i][j] = 1;
				cnt++;
			}
		}
	}

	for(int i = 1; i < n-1; i++)
	{
		for(int j = 1; j < m-1; j++)
		{
			if(grid[i][j] == 0) continue;
			if(!(grid[i-1][j] == 1 and grid[i+1][j] == 1 and grid[i][j-1] == 1 and grid[i][j+1] == 1)) continue;
			if(grid[i+1][j+1] == 1 or grid[i-1][j-1] == 1 or grid[i+1][j-1] == 1 or grid[i-1][j+1] ==1) continue;
			int x = cnt;
			vector<vector<int>> rem = crossout(i,j,x);
			
			if(x == 0)
			{
				cout << "YES"; return;
			}
			else
			{
				cout << "NO"; return;
			}
		}
	}

	cout << "NO";

}
```