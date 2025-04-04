# round dance
---
>[!summary] Fun codeforces problem


# Explanation
---
This is a [[graph]] problem that makes substantial use of the [[Union-find structure]] (or DSU). 

Essentially you need 2 pieces of info to solve this problem:
1. The number of **'components'** in the graph, we do this using a typical [[Union-find structure]] approach.
2. The number of **'dangilng'** edges

By **'dangling'** I mean a node that has **one free edge to spare**. 
We can find this by finding all nodes with a degree of **1**, and divide by 2^[to make up for the fact that these are **undirected** edges]. 
One of these "dangling" edges are going to have to be spent to **close the loop** in the round dance, so we can just *subtract 1 from our count*.

The leftover number of edges are those that can be used to connect two unconnected components of the graph. Optimally doing so would mean that the least number of components we'd have by spending said edges would be $$min=components-dangling$$
That's it! 👍

> [!info] A `std::set<>` structure in c++ is very useful for ignoring duplicates!

# Code
---
```cpp

vector<int> nxt;

int find(int n){
	while(nxt[n] != n)
		n = nxt[n];
	return n;
}

void join(int a, int b) {
	nxt[a] = find(b);
}

void solve(int tc)
{
	int n; cin >> n;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++){
		cin >> a[i];
		a[i]--;
	}

	nxt = vector<int>(n,0);
	iota(nxt.begin(), nxt.end(), 0);


	//vector<vector<int>> graph(n, vector<int>(n,0));
	//unordered_map<int, unordered_set<int>> adj;

	int components = 0;
	int dangling = 0;


	unordered_map<int, set<int>> graph;
	for(int i = 0; i < n; i++)
	{
		join(i, a[i]);
		graph[i].insert(a[i]);
		graph[a[i]].insert(i);
	}

	for(auto i : graph)
	{
		if(i.second.size() == 1) dangling++;
		/*
		cout << i.first << " : ";
		for(auto j : i.second)
			cout << j << ", ";
		cout << endl;
		*/
	}

	dangling /= 2;
	dangling--;


	for(int i = 0; i < n; i++)
	{
		if(find(i) == i) components++;
	}


	if(dangling > 0)
	{
		cout << components-dangling << " "; // min
	}
	else cout << components << " "; // min


	cout << components << endl; // max

}


```