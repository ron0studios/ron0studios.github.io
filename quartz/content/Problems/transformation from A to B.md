---
aliases: 
date: 
time taken (mins):
---

# transformation from A to B
---
>[!summary] Simple CF problem. took around 15 mins


# Explanation
---
this is a classic [[recursion]] [[complete search]] problem, similar to BIO1 q3.  Just need to brute force all the options and break out of recursion when a solution is found.

# Code
---
```cpp
ll b;
unordered_map<ll,bool> vis;
bool stop = false;

void compute(ll x, vector<ll> trace={}){
	if(stop) return;
	if(x>1000000000) return;

	if(x==b){
		cout << "YES" << endl;
		cout << trace.size() << endl;
		for(auto i : trace)
			cout << i << " ";
		stop = true;
	}

	if(!vis.count(x*2)){
		vis[x*2] = true;
		trace.pb(x*2);
		compute(x*2, trace);
		trace.pop_back();
	}

	if(!vis.count(x*10+1)){
		vis[x*10+1] = true;
		trace.pb(x*10+1);
		compute(x*10+1, trace);
		trace.pop_back();
	}
}

void solve()
{
	ll a; cin >> a >> b;

	compute(a, {a});
	if(!stop) cout << "NO";
}
```