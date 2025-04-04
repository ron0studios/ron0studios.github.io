# bovine genomics
---
>[!summary] pretty simple usaco bronze 2


# Explanation
---
This is an [[complete search#Iteratively|iterative complete search]] problem. You just loop through and find common elements using a [[hash map]]

# Code
---
```cpp

void solve()
{
	freopen("cownomics.in","r",stdin);
	freopen("cownomics.out","w",stdout);
	int n, m; cin >> n >> m;
	vector<vector<char>> gspot(n,vector<char>(m,0));
	vector<vector<char>> gclean(n,vector<char>(m,0));

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			cin >> gspot[i][j];
		}
	}

	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < m; j++)
		{
			cin >> gclean[i][j];
		}
	}

	
	int c = 0; 
	for(int i = 0; i < m; i++) // column
	{
		unordered_map<char,bool> common; 
		for(int j = 0; j < n; j++) // row
		{
			common[gclean[j][i]] = true;
		}

		bool check = true;
		for(int j = 0; j < n; j++)
		{
			if(common.count(gspot[j][i]))
			{
				check = false;
				break;
			}
		}

		if(check) c++; // lol
	}

	cout << c;
}


```