# good tuple problem
---
>[!summary] its in the name. atcoder problem (https://atcoder.jp/contests/abc327/tasks/abc327_d)


# Explanation
---
This was a pretty nasty problem. It initially looked like a cycle detection problem, because all odd numbered cycles are impossible to create a valid $X$ pattern with. 
However, it turns out it is actually a question about [[Algorithms/bipartite graphs|Bipartite graphs]]. If you label the root of each **component**  of the tree as a **1**, and run the bipartite detection algorithm on each component, using a [[Union-find structure]], then you can confirm if the pairs are valid if every component can be made bipartite. 

If not, if you think about it, you conclude that no matter what kind of way you group the graph into two groups of 1 and 0, there will always be an edge connecting within one of the groups, meaning that edge demands that two nodes labelled the same number to be different, which is invalid. 
# Code
---
```cpp

void solve()
{
	int n, m; cin >> n >> m;
	vector<int> a(m);
	vector<int> b(m);
	for(int i = 0; i < m; i++){
		cin >> a[i];
		a[i]--;
	}
	for(int i = 0; i < m; i++){
		cin >> b[i];
		b[i]--;
	}
	for(int i = 0; i < m; i++){
		if(a[i] == b[i])
		{
			cout << "No\n"; return;
		}
	}

	vector<pair<int,int>> pairs;
	for(int i = 0; i < m; i++){
		pairs.pb(mp(min(a[i],b[i]), max(a[i],b[i])));
	}
	set<pair<int,int>> s(pairs.begin(), pairs.end());
	pairs.assign(s.begin(),s.end());
	m = pairs.size();

	unordered_map<int,vector<int>> graph;
	for(int i = 0; i < m; i++)
	{
		graph[pairs[i].first].pb(pairs[i].second);
		graph[pairs[i].second].pb(pairs[i].first);
	}



	vector<int> link(n); iota(link.begin(),link.end(),0);
	vector<int> size(n,1);

	for(int i = 0; i < m; i++)
	{
		int x = pairs[i].first;
		int y = pairs[i].second;
		while(x!=link[x]) x = link[x];
		while(y!=link[y]) y = link[y];

		if(size[x] < size[y]) swap(x,y);
		size[x] += size[y];
		link[y] = x;
	}


	vector<int> roots;
	for(int i = 0; i < n; i++)
		if(link[i] == i) roots.pb(i);

	for(int start = 0; start < roots.size(); start++){
		queue<int> q; q.push(roots[start]);
		unordered_map<int,int> color; color[roots[start]] = 1;

		while(!q.empty()) {
			int node = q.front(); q.pop();
			int curr = color[node];

			for(auto i : graph[node])
			{
				if(color[i] == 0)
				{
					color[i] = -curr;
					q.push(i);
				}
				else{
					if(color[i] == curr)
					{
						cout << "No\n"; return;
					}
				}
			}
		}
	}


	cout << "Yes\n";
}


```