# Dima and friends
[[maths]]
https://codeforces.com/problemset/problem/272/A
# Code
```c++
void solve(int tc)
{
	int n; cin >> n;
	vector<int> fingers; inveci(n,fingers)
	int t = accumulate(fingers.begin(), fingers.end(), 0); 
	int out = 0;
	n++;
	for(int i = 1; i <= 5; i++)
	{
		if((t+i) % n != 1)
		{
			out++;
		}
	}
	cout << out;
}
```