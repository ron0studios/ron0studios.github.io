# copil copac draws trees
---
>[!summary] very hard codeforces problem


# Explanation
---

This is an interesting mix of [[dynamic programming|DP]] and [[DFS]]. 

Essentially, we initialise two structures
`dp[i]`, which stores the number of scans needed to reach node $i$. 
`id[i]`, which stores the index of the edge^[from the order of edges in the input] that activated node $i$. 

From there, we can run a [[DFS]] search through the entire tree.

> [!warning] watch out
> The question specifies that the input will always be in the form of a tree, **but that does not mean that the edges will be the right way around!**.
> please make sure to either add 2 way edges.

When we traverse an edge (that has been unvisited):
- If the **index** of the edge in the input list is **greater than or equal to** the **ID** location of the incoming node, i.e for edge $(u,v)$, if $index((u,v)) \geq id[u]$
	- in this case we can conclude the number of passes needed to reach $\pmb{V}$ is **the same** as the number of passes to reach $\pmb{U}$, since the position of the index reaching $\pmb{U}$, comes before $\pmb{V}$, meaning once one is discovered the one after gets discovered in the same pass.
- In the **other case**, where the **index is lower**
	- We conclude the number of passes needed to reach $\pmb{V}$ is **one greater than** the number of passes to reach $\pmb{U}$, since discovering $\pmb{U}$ is dependant on if $\pmb{V}$ is discovered, so it can only be reached **one pass after** $\pmb{V}$ is reached.

The answer will be $$max^{N}_{i=0}(dp_i)$$


# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<vector<int>> edges(n-1,vector<int>(2,0));
	map<pair<int,int>, int> idxs;
	for(int i = 0; i < n-1; i++){
		int x,y;
		cin >> x >> y;
		edges[i][0] = min(x,y);
		edges[i][1] = max(x,y);
		idxs[mp(edges[i][0],edges[i][1])] = i;
	}

	
	unordered_map<int,vector<int>> tree;
	for(int i = 0; i < n-1; i++){
		tree[edges[i][0]].pb(edges[i][1]);
		tree[edges[i][1]].pb(edges[i][0]);
	}

	
	vector<int> dp(n+1,0); dp[1] = 1;
	vector<int> id(n+1,-1); id[1] = 0;
	unordered_map<int,bool> vis; vis[1] = true;
	stack<pair<int,int>> traverse;
	traverse.push(mp(0,1));


	while(!traverse.empty()){
		pair<int,int> item = traverse.top(); traverse.pop();
		for(auto i : tree[item.second])
		{
			if(vis[i]) continue;
			vis[i] = true;

			int loc = idxs[mp(min(item.second,i),max(item.second,i))];

			if(loc >= id[item.second])
			{
				dp[i] = dp[item.second];
				id[i] = loc;
			}
			else
			{
				dp[i] = dp[item.second] + 1;
				id[i] = loc;
			}

			traverse.push(mp(item.second, i));
		}
	}

	cout << *max_element(dp.begin(), dp.end()) << endl;
}
```