#bio
# Juggl(ug)ing
---
> An interesting problem for Q3 of the 2010 BIO


# Explanation
---
This problem is remarkably similar to [[shirts]], requiring the [[BFS]] algorithm instead of recursion to explore layers of a [[complete search]] tree. 
Small optimizations were required to keep the worst case scenario's computing time under 2 seconds. 

# Code
---
```cpp

void solve(int tc)
{
	int num_jugs, target; cin >> num_jugs >> target;
	vector<pair<int,int>> jugs(num_jugs,pair<int,int>(0,0));
	for(int i = 0; i < num_jugs; i++)
		cin >> jugs[i].second;

	// bfs
	queue<pair<vector<pair<int,int>>,int>> q;
	
	map<vector<pair<int,int>>, bool> visited;

	q.push(mp(jugs,0));
	visited[jugs] = true;

	int out = 0;

	while(!q.empty())
	{
		pair<vector<pair<int,int>>,int> x = q.front(); q.pop();

		/*
		cout << "LAYER:" << x.second << "\n";
		for(auto j : x.first)
		{
			cout << j.first << " " << j.second << "\n";
		}
		cout << "\n";
		*/

		for(auto i : x.first) 
			if(i.first == target) // answer found
			{
				// debug
				for(auto j : x.first)
				{
					cout << j.first << " " << j.second << "\n";
				}
				cout << "\n";

				out = x.second;
				cout << out << "\n";
				return;
			}

		vector<pair<int,int>> tmp;
		
		// option 1, pouring from A -> B
		for(int i = 0; i < x.first.size(); i++)
		{
			for(int j = 0; j < x.first.size(); j++)
			{
				if(j != i)
				{
					tmp = x.first;
					// fill all of i (or as much as possible) onto j
					tmp[j].first += tmp[i].first; 
					if(tmp[j].first > tmp[j].second) // i.e overfilled
					{
						int extra = tmp[j].first - tmp[j].second; 
						tmp[i].first = extra;
						tmp[j].first = tmp[j].second;
					}
					else // under or exactly filled
					{
						tmp[i].first = 0;
					}
					
					if(visited[tmp] != true)
					{
						visited[tmp] = true;
						q.push(mp(tmp,x.second+1)); 
					}
						
				}
			}
		}

		// option 2, emptying A
		for(int i = 0; i < x.first.size(); i++)
		{
			tmp = x.first; 
			tmp[i].first = 0; 
			if(!visited[tmp])
			{
				visited[tmp] = true; 
				q.push(mp(tmp,x.second+1));
			}
		}

		// option 3, filling A
		for(int i = 0; i < x.first.size(); i++)
		{
			tmp = x.first; 
			tmp[i].first = tmp[i].second; 
			if(!visited[tmp])
			{
				visited[tmp] = true; 
				q.push(mp(tmp,x.second+1));
			}
		}
	}
}


```