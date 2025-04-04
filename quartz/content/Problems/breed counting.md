# breed counting
---
> USACO 2015 december silver question 3


# Explanation
---
A pretty easy problem requiring knowledge on using a [[prefix sum]], with the twist being you have to use *3 different prefix sums* for each breed.

# Code
---
```cpp
void solve()
{
	freopen("bcount.in","r",stdin);
	int n, q; cin >> n >> q;
	vector<int> cows(n,0);
	vector<pair<int,int>> queries(q,mp(0,0)); 

	for(int i = 0; i < n; i++)
		cin >> cows[i];
	for(int i = 0; i < q; i++)
		cin >> queries[i].first >> queries[i].second;

	vector<vector<int>> prefixes(3, vector<int>(n+1, 0)); // n+1, including 0 

	for(int i = 0; i < n; i++)
	{
		int curr = cows[i];
		for(int j = 0; j < 3; j++)
		{
			if(j == curr-1)
			{
				prefixes[j][i+1] = prefixes[j][i] + 1;
			}
			else
			{
				prefixes[j][i+1] = prefixes[j][i];
			}
		}
	}

	freopen("bcount.out","w",stdout);
	for(auto query : queries)
	{
		cout << prefixes[0][query.second] - prefixes[0][query.first-1] << " ";
		cout << prefixes[1][query.second] - prefixes[1][query.first-1] << " ";
		cout << prefixes[2][query.second] - prefixes[2][query.first-1];
		cout << "\n";
	}

}
```