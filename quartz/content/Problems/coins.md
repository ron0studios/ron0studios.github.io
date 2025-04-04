# coins
---
>[!summary] Hard atcoder problem


# Explanation
---
This was a hard to understand atcoder [[dynamic programming]] problem, that involves (somewhat) [[combinatorics]], and is useful for many combinatorics questions.

It works off of a probability tree, and follows off of [[the knapsack problem]] in terms of how we can pick items, instead there is no option to *not* pick an item, instead, it is the **state** of the item, which in this case, is whether a coin lands *heads* or *tails*.

We'll use a condensed 1-D array `dp[x]`, where `x` refers to the probability of having `x` heads.^[note that this can be done in a 2D array `dp[i][x]`, referring to the probability of having `x` heads using the first `i` coins, but y'know, space complexity is a thing]



# Code
---
```cpp

void solve()
{
	int n; cin >> n;

	// probability of "i" heads
	vector<double> dp(n+1,0);

	dp[0] = 1;
	for(int i = 0; i < n; i++)
	{
		double x; cin >> x;
		
		for(int j = i+1; j >= 0; j--)
		{
			dp[j] = (j==0 ? 0 : dp[j-1] * x) + (dp[j] * (1-x));
		}
	}
	
	double out = 0;
	for(int i = 0; i <= n; i++)
	{
		if(i >= ceil((float)n/2))
		{
			out += dp[i];
		}
	}
	cout << fixed << setprecision(10) << out; 

}


```

# Code (recursive)
slower, but easier to understand whats going on
```cpp

int n; vector<double> coins;

vector<vector<double>> dp(3007, vector<double>(3007, -1.0d));

double compute(int depth = 0, int heads = 0){
	if(depth == n)
	{
		if(heads > floor(n/2.0f)){
			return 1;
		}
		return 0;
	}

	if(dp[depth][heads] != -1.0d){
		return dp[depth][heads];
	}

	double tot = 0; 
	tot += coins[depth]*compute(depth+1, heads+1);
	tot += (1-coins[depth])*compute(depth+1, heads);


	return dp[depth][heads] = tot;
}

void solve()
{
	cin >> n;
	cout << setprecision(10);
	coins = vector<double>(n,0);
	for(int i = 0; i < n; i++)
		cin >> coins[i];


	cout << compute();
}


```