# cow gymnastics
---
>[!summary] usaco problem


# Explanation
---
This is a [[complete search#Iteratively|iterative complete search]] problem

# Code
---
```cpp

void solve()
{
	freopen("gymnastics.in","r",stdin);
	freopen("gymnastics.out","w",stdout);
	int k,n; cin >> k >> n;
	vector<vector<int>> sessions(k,vector<int>(n,0));
	for(int i = 0; i < k; i++)
	{
		for(int j = 0; j < n; j++)
		{
			cin >> sessions[i][j];
		}
	}


	vector<pair<int,int>> out; 
	for(int i = 1; i <= n; i++)
	{
		for(int j = 1; j <= n; j++)
		{
			if(i==j) continue;
			//cout << i << " " << j << endl;
			bool valid = true;
			for(int row = 0; row < k; row++)
			{
				bool exist1 = find(sessions[row].begin(), sessions[row].end(), i) != sessions[row].end();
				bool exist2 = find(sessions[row].begin(), sessions[row].end(), j) != sessions[row].end();

				//if(i == 1 and j == 3)	cout << exist1 << " " << exist2 << "\n";
				if(!exist2) continue;
				if(!exist1)
				{
					valid = false; break;
				}

				int pos1 = find(sessions[row].begin(), sessions[row].end(), i) - sessions[row].begin();
				int pos2 = find(sessions[row].begin(), sessions[row].end(), j) - sessions[row].begin();

				if(pos1 > pos2)
				{
					valid = false; break;
				}
			}
			if(valid)
			{
				out.pb(mp(i,j));
			}
		}
	}

	cout << out.size() << "\n";
	/*
	for(auto i : out)
	{
		cout << i.first << " " << i.second << "\n";
	}
	*/
}


```