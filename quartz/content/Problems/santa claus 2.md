# santa claus 2
---
>[!summary] abc385 D. An interesting [[binary search]] problem. Took around 40 mins


# Explanation
---
This problem is a harder version of [[santa claus 1]]. In this problem you are required to detect all `N` presents when santa moves `C` steps in any one of the 4 directions, Left, Up, Down and Right. 
Since `C` can be up to 10^5, and there are 10^5 different steps that santa makes, it is infeasible to manually move santa by 1 every time. Instead we move santa by the whole segment, and search for any presents within the segment, stored in a [[hash map]] of vectors, which we search through using [[binary search]].
# Code
---
```cpp
void solve()
{
	ll n, m; cin >> n >> m;
	ll px, py; cin >> px >> py;
	unordered_map<ll, vector<ll>> rows;
	unordered_map<ll, vector<ll>> cols;
	map<pair<ll,ll>, bool> visited;
	for(ll i = 0; i < n; i++){
		ll x,y; cin >> x >> y;
		if(rows.count(x)){
			auto idx = lower_bound(rows[x].begin(), rows[x].end(), y);
			rows[x].insert(idx, y);
		} else rows[x] = {y};
		if(cols.count(y)){
			auto idx = lower_bound(cols[y].begin(), cols[y].end(), x);
			cols[y].insert(idx, x);
		} else cols[y] = {x};
	}

	if(binary_search(rows[px].begin(), rows[px].end(), py) and binary_search(cols[py].begin(), cols[py].end(), px)){
		visited[mp(px,py)] = true;
	}

	unordered_map<char,pair<ll,ll>> dirs;
	dirs['U'] = mp(-1,0);
	dirs['D'] = mp(1,0);
	dirs['L'] = mp(0,-1);
	dirs['R'] = mp(0,1);
	for(ll i =0; i < m; i++){
		char instr; ll c; cin >> instr >> c;
		if(instr == 'U' or instr == 'D'){
			ll a = py; ll b = py;
			if(instr == 'D'){
				a = py-c;
				b = py;
			}
			else b = py+c;

			if(rows.count(px)) {
				auto start = lower_bound(rows[px].begin(), rows[px].end(), a);
				if(start != rows[px].end()){
					ll idx = start-rows[px].begin();
					for(ll j = idx; j < rows[px].size(); j++){
						if(rows[px][j] > b) break;
						visited[mp(px, rows[px][j])] = true;
					}
				}
			}

			px = px;
			py = (instr=='D') ? py-c : py+c;

		}
		else if(instr == 'L' or instr =='R'){
			ll a = px; ll b = px;
			if(instr == 'L'){ 
				a = px-c;
				b = px;
			}
			else b = px+c;

			if(cols.count(py)) {
				auto start = lower_bound(cols[py].begin(), cols[py].end(), a);
				if(start != cols[py].end()){
					ll idx = start-cols[py].begin();
					for(ll j = idx; j < cols[py].size(); j++){
						if(cols[py][j] > b) break;
						visited[mp(cols[py][j], py)] = true;
					}
				}
			}

			px = (instr=='L') ? px-c : px + c;
			py = py;

		}
	}

	cout << px << " " << py << " " << visited.size() << endl;

}
```