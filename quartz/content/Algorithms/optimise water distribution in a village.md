# optimise water distribution in a village
---
>[!summary] A very hard Leetcode problem

# Explanation
---
This is a very hard leetcode problem, but is made trivial with a niche trick!
This problem requires knowledge on [[Minimum Spanning Tree]]
Essentially, the trick is to actually add the wells as their own nodes in the graph! You can then assign the costs of the wells as their own edges connecting from that well vertex to every other node.
After this you can run a typical MST algorithm like [[Kruskal's algorithm]]. 
# Code
---
```cpp
bool comp(vector<int> a,vector<int> b){
	return a[2] < b[2];
}


class UFS // union-find structure
{
	public:
		vector<int> link; // an array from all vertices 0-V. link[N] will point to the vertice it is linked to.

		UFS(int V)
		{
			for(int i = 0; i < V; i++) link.pb(i);
		}

		// finds the representative of a vertex
		int find(int x)
		{
			while(x != link[x]) x = link[x];
			return x;
		}

		// self-explanatory
		bool same(int a, int b)
		{
			return find(a) == find(b);
		}

		// unites two components
		void unite(int a, int b)
		{
			a = find(a);
			b = find(b);
			link[b] = a;
		}
};


void solve(int tc)
{
	int n; cin >> n;
	vector<int> wells(n,0); 
	for(int i = 0; i < n; i++)
		cin >> wells[i];
	int p; cin >> p;
	vector<vector<int>> pipes(p,vector<int>(3,0));
	for(int i = 0; i < p; i++)
		cin >> pipes[i][0] >> pipes[i][1] >> pipes[i][2];
	
	// add wells as their own nodes, with their cost as edges to all homes!
	for(int i = 0; i < n; i++)
	{
		for(int j = 1; j <= n; j++)
			pipes.pb({200+i, j, wells[i]});
	}
	
	sort(pipes.begin(),pipes.end(),comp);
	sort(wells.begin(),wells.end());
	
	vector<vector<int>> mst;
	int out = 0;
	UFS kruskal(n*2);
	for(auto i : pipes)
	{
		if(!kruskal.same(i[0],i[1]))
		{
			out += i[2];
			kruskal.unite(i[0],i[1]);
			mst.pb(i);
		}
	}
	cout << out << endl;
}


```