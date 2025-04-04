# Super Central point
https://codeforces.com/problemset/problem/165/A

## Code
No need to overcomplicate it. It is an infinite plane [[matrix]], and simple scan of the x and y components **individually** would work as said on [[matrix#^4fa5fa|this tip]]. No need for optimisation, simple linear scans and an O(n^2) time is all that is needed, but it would be better to do one linear scan, for each element, rather than 4 linear scans for each element. 
```c++
void solve(int tc)
{
	int n; cin >> n;
	vector<pair<int,int>> b;
	for(int i = 0; i < n; i++)
	{
		int x,y; cin >> x >> y;
		b.pb(mp(x,y));
	}

	int scpoints = 0;
	for(auto i : b)
	{
		bool up = false;
		bool down = false;
		bool left = false;
		bool right = false;
		for(auto j : b)
		{
			if(j.first > i.first && i.second == j.second)
				right=true;
			if(j.first < i.first && i.second == j.second)
				left = true;
			if(j.first == i.first && i.second > j.second)
				up = true;
			if(j.first == i.first && i.second < j.second)
				down = true;
		}
		if(up and down and left and right)
			scpoints++;
	}
	cout << scpoints;
}
```