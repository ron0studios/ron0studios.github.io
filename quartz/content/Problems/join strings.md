# join strings
---
>[!summary] kattis-joinstrings. A simple [[DFS]] problem. Took an hour (me being silly)


# Explanation
---
All you need for this problem is to create a [[tree]] from the different string joins and perform a [[DFS|depth first search]]  on the tree, making sure to add children to the [[stack]] **in reverse**.
# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<string> words(n);
	vector<vector<int>> join(n);
	for(int i = 0; i < n; i++) {
		cin >> words[i];
		join[i] = {i};
	}

	unordered_map<int, vector<int>> tree;

	string out = "";
	int o = 0;
	for(int i = 1; i < n; i++){
		int a,b; cin >> a >> b;
		a--; b--;
		o = a;
		tree[a].pb(b);
	}

	vector<int> stack = {o};
	while(!stack.empty()){
		int top = stack.back(); stack.pop_back();
		cout << words[top];
		for(int i = tree[top].size()-1; i >= 0; i--){
			stack.pb(tree[top][i]);
		}
	}
}
```