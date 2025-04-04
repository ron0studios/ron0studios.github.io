# Travel Restrictions
https://www.facebook.com/codingcompetitions/hacker-cup/2020/qualification-round/problems/A

## Code
simple simulation, for each element in the [[matrix]], check if j is reachable from i by following the [[Linked list]]ish type graph. 
```c++
void solve(int tc)
{
	int n; cin >> n;
	string a, b; cin >> a >> b;
	cout << "Case #" << tc << ":\n";
	vector<vector<char>> mat(n,vector<char>(n,'Y'));
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
		{
			if(i <= j)	
			{
			for(int k = i; k < j; k++)
			{
				if(b[k] != 'Y' || a[k+1] != 'Y')
				{
					mat[i][j] = 'N';
				}
			}
			}
			else {
			for(int k = i; k > j; k--)
			{
				if(b[k] != 'Y' || a[k-1] != 'Y')
				{
					mat[i][j] = 'N';
				}
			}
			}
		}
	}
	for(auto i : mat)
	{
		for(auto j : i)
			cout << j;
		cout<<"\n";
	}
}
```