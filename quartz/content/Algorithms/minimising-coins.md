# Minimising coins 
---
> Given a set of available coin types and an integer **N**, what is the minimum amount of coins required? 


# Explanation
---
This is a very similar problem to [[Coin Change]], with the only difference being that we want to find the **minimum** number of coins, rather than the number of possibilities. 
We can solve this problem by using [[dynamic programming]], creating an array, similar to [[Coin Change]]^[remember that the array size is **N+1**, not N!].
There is a possibility that it is *impossible* to create a sum given the coins given, so we are going to save that as *1e9* or *INT_MAX*^[during output, however, if it is 1e9, we will print -1]
For each state, we take the minimum of that index of the memo, minus all of the different coins we have. 

# Code
---
```c++
void solve(int tc)
{
	int N, X; cin >> N >> X;
	vector<int> a; inveci(N,a)
	vector<int> demo(X+1,INF);
	

	demo[0] = 0;
	for(int i = 1; i <= X; i++)
	{
		for(auto j : a)
		{
			if(i-j >= 0)
			{
				demo[i] = min(demo[i],demo[i-j]+1);
			}
		}
	}

	cout << ((demo[X] == INF) ? -1 : demo[X]) << "\n";
}
```