# Jzzhu and children
https://codeforces.com/problemset/problem/450/A

Uses a [[queue]] data structure to implement the solution to the problem. Also have a [[hash map]] to store the index-value pairs of the elements

## Code
```c++
void solve(int tc)
{
	int n, m; cin >> n >> m;

	unordered_map<int,int> h;
	queue<int> q;
	for(int i = 0; i < n; i++)
	{
		int x; cin >> x;
		q.push(i);
		h[i] = x;
	}

	while(q.size() > 1)
	{
		auto x = q.front(); q.pop();
		if(h[x]-m > 0)
		{
			h[x] -= m;
			q.push(x);
		}
	}
	cout << q.front() + 1;

}
```