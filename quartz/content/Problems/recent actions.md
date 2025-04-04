# recent actions
---
>[!summary] a finicky, but straightforward CF problem


# Explanation
---
This problem needs a lot of [[hash map|hashmaps]] and arrays to work but it is generally an [[ad hoc]] problem, where you just simulate the test case.


# Code
---
```cpp
void solve(int tc)
{
	int n, m; cin >> n >> m;
	vector<int> actions(m,0);
	for(int i = 0; i < m; i++)
		cin >> actions[i];

	deque<int> recent;
	vector<int> out(n+1,-1);
	unordered_map<int, bool> present;
	for(int i = 1; i <= n; i++){
		recent.pb(i);
		present[i] = true;
	}


	for(int i = 0; i < m; i++)
	{
		if(not present[actions[i]])
		{
			recent.push_front(actions[i]);
			present[actions[i]] = true;
			present[recent.back()] = false;
			if(recent.back() <= n and out[recent.back()]==-1) out[recent.back()] = i;
			recent.pop_back();
		}
		else
		{
			int a = find(recent.begin(), recent.end(), actions[i])-recent.begin();
			recent[a] = recent[0];
			recent[0] = actions[i];
		}
	}

	for(int i = 1; i <= n; i++)
	{
		cout << ((out[i]==-1) ? out[i] : out[i]+1) << " ";
	}
	cout << endl;
}
```