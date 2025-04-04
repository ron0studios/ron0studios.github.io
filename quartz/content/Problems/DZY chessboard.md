# DZY loves chessboard
https://codeforces.com/problemset/problem/445/A
#implementation 

## Code
make sure to add the extra swap for *white* if the number of columns is even in the [[matrix]], since you can end up with an answer like this:
>
BWBW
BWBW
BWBW

which has adjacent cells with the same value.
```c++
void solve(int tc)
{
	int n,m; cin >> n >> m; 
	// . = good - = bad
	vector<vector<char>> mat(n,vector<char>(m,0));

	for(int i = 0; i <  n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			char x; cin >> x;
			mat[i][j] = x;
		}
	}

	bool white = true;
	for(int i = 0; i < n; i++)
	{
		if(m%2==0) white = !white;
		for(int j = 0; j < m; j++) 
		{
			white = !white;
			if(mat[i][j] == '.') 
			{
				mat[i][j] = (white) ? 'W' : 'B';
			}
		}
	}

	for(auto i : mat)
	{
		for(auto j : i)
			cout << j;
		cout << "\n";
	}
}

```