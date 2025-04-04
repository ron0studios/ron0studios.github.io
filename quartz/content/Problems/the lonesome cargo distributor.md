# the lonesome cargo distributor
---
>[!summary] UVA 10172. An [[ad hoc]] [[stack]] and [[queue]] problem. took around 1 hour because i was misinterpreting the question


# Explanation
---
Just need to **simulate** the cargo carrier by pulling from the stack and pushing to the queue. make sure to subtract 2 from the final output since the final movement between 2 stations is done **after** all the cargo has been distributed. 

note that we don't need to find the *minimum* time needed to distribute the cargo since the problem statement already outlines a precise algorithm to take for the cargo carrier, and therefore we don't need to come up with our own distribution method and just use the one that the problem state provides.
# Code
---
```cpp
void solve(int tc)
{
	int n,s,q; cin >> n >> s >> q;
	vector<queue<int>> stations(n);
	int tot = 0;
	int cur = 0;
	int time = 0;
	vector<int> stack;
	for(int i = 0; i < n; i++) {
		int num; cin >> num;
		tot += num;
		for(int j = 0; j < num; j++){
			int x; cin >> x;
			x--;
			stations[i].push(x);
		}
	}

	while(tot){
		// unloading
		while(!stack.empty()){
			if(stack.back()==cur){
				tot--; stack.pop_back();
			} else if(stations[cur].size() < q){
				stations[cur].push(stack.back());
				stack.pop_back();
			} else break;
			time ++;
		}

		// loading
		while(stack.size() < s and !stations[cur].empty()){
			stack.pb(stations[cur].front());
			stations[cur].pop();
			time++;
		}

		time += 2;
		cur++; cur %= n;
	}
	time -= 2;

	cout << time << endl;
}
```