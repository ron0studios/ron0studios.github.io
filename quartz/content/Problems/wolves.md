# wolves
---
>[!summary] Fun BAO problem


# Explanation
---
this is a [[dynamic programming|DP]] problem where you create a somewhat of a [[bipartite graphs|bipartite graph]] and brute force all the possible combinations, saving states by their recursive depth.
# Code
---
```cpp

unordered_map<int, vector<int>> inter;
vector<string> out;
string wolves;

unordered_map<int,int> dp;
unordered_map<string, bool> done;

int compute(string cur="", int d=-1, vector<int> exclude=vector<int>(26,0)){

	if(dp.count(d)){
		return dp[d];
	}

	int tot = 1;
	for(int i = d+1; i < wolves.size(); i++)
	{
		if(exclude[i]) continue;
		vector<int> tmp(26,0);
		for(auto j : inter[i])
			tmp[j] = 1;

		tot += compute(cur+string(1,'A'+i), i, tmp);
	}

	return dp[d] = tot;
}

void solve(int tc)
{
	cin >> wolves;
	vector<int> dist(wolves.size(),0);
	inter = unordered_map<int, vector<int>>();
	out = vector<string>();
	dp = unordered_map<int, int>();

	for(int i = 0; i < wolves.size(); i++)
	{
		int pos = wolves[i]-'a';
		dist[i] = pos-i;
	}

	for(int i = 0; i < wolves.size(); i++){
		//if(dist[i]==0) continue;
		
		if(dist[i]>0){
			for(int j = i+1; j < wolves.size(); j++){
				if(j+dist[j] > i+dist[i]) continue;
				inter[i].pb(j);
				inter[j].pb(i);
			}
		}
		else{
			for(int j = i-1; j >= 0; j--){
				if(j+dist[j] < i+dist[i]) continue;
				inter[i].pb(j);
				inter[j].pb(i);
			}
		}
	}

	for(int i = 0; i < wolves.size(); i++)
	{
		set<int> s(inter[i].begin(), inter[i].end());
		inter[i].assign(s.begin(), s.end());
	}
	cout << compute()-1;
}


```