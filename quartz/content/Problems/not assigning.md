# not assigning
---
>[!summary] A codeforces problem


# Explanation
---
This was a pretty [[maths]] based problem. You had to realise that it is impossible to create a prime-tree from a node with more than 2 edges, since only an Odd-Even pair of prime numbers (i.e any prime number and a 2) can make another prime number, and once you add a third number you're guaranteed to introduce two odds, which makes an even, which can't be a prime number. 

Once realising that, the best approach is to simply alternate between 2 and 3. 

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<pair<int,int>> edges(n-1);
	for(int i = 0; i < n-1; i++)
		cin >> edges[i].first >> edges[i].second;

	
	unordered_map<int,vector<int>> graph;
	for(auto i : edges)
	{
		graph[i.first].pb(i.second);
		graph[i.second].pb(i.first);
	}


	for(int i = 1; i <= n; i++)
	{
		if(graph[i].size() > 2)
		{
			cout << "-1" << endl;
			return;
		}
	}

	int root = -1;
	for(int i = 1; i <= n; i++){
		if(graph[i].size() == 1)
		{
			root = i; break;
		}
	}


	vector<bool> vis(n+1,false);
	vis[root] = true;
	int cur = root; 
	int prime = 2;
	map<pair<int,int>,int> label;
	while(true)
	{
		if(cur != root and graph[cur].size() == 1)
			break;
		
		for(int i = 0; i < graph[cur].size(); i++)
		{
			if(vis[graph[cur][i]]) continue;
			vis[graph[cur][i]] = true;
			label[mp(min(graph[cur][i], cur), max(graph[cur][i],cur))] = prime;
			if(prime == 2) prime++;
			else prime--;
			cur = graph[cur][i];
		}
	}


	for(auto i : edges)
	{
		cout << label[mp(min(i.first,i.second), max(i.first,i.second))] << " ";
	}
	cout << endl;
	
}
```