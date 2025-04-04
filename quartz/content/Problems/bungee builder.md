# bungee builder
---
>[!summary] kattis-bungeebuilder. An interesting [[stack]] problem. Took around 1 hour


# Explanation
---
This requires you to run **2** stack algorithms. One going from left and right, finding the longest bridge going from the top of a left mountain to any right mountain, and the other going from right to left from the top of a right mountain to any left mountain. The maximum drop found in either function is the answer. 
# Code
---
```cpp
int compute(int n, vector<int> inp){
	vector<pair<int,int>> stack;
	int out = INT_MAX;
	for(int i = 0; i < n; i++){
		int x = inp[i];
		int mn = INT_MAX;
		if(!stack.empty() and x >= stack.back().first){
			while(!stack.empty() and x >= stack.back().first){
				mn = min(mn, stack.back().second);
				stack.back().second = min(stack.back().second, mn);
				out = min(out, stack.back().second-stack.back().first);
				stack.pop_back();
			}
			if(!stack.empty()) {
				stack.back().second = min(stack.back().second, mn);
			}
		}
		stack.pb(mp(x, x));
	}

	if(out==INT_MAX) return 0;
	else return -out;


}

void solve()
{
	int n; cin >> n;
	vector<int> inp(n);
	for(int i = 0; i < n; i++)
		cin >> inp[i];

	int a = compute(n, inp);
	reverse(inp.begin(), inp.end());
	int b = compute(n, inp);
	cout << max(a,b) << endl;
}
```