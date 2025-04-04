# sushi
---
>[!summary] **VERY HARD** problem from atcoder


# Explanation
---
This is a [[dynamic programming]] problem that requires good knowledge on [[Algorithms/Probability]]


You have a dp state `dp[a][b][c]`, where `a` is the number of single sushi plates, `b` is the number of two sushi plates, and `c` is the number of 3 sushi plates. 

We don't need a state for the number of 0 sushi plates because we can simply calculate it by doing $N- (a+b+c)$ where $N$ is the total number of plates. 

We'll be doing this recursively because it's easier than doing it iteratively. We'll initialise all DP values as -1 and have a base case `a = b = c = 0`, which will be 0, since it takes 0 operations to empty all the plates.


## transitions
---
The transitions are where it gets harder. We need to understand *expected value*. 

Our formula for calculating the expected value for each of the transitions is: 
$$
dp[a][b][c] =\sum\limits \begin{cases}(dp[a-1][b][c] + EV(transition)) \times P(transition) \\  
(dp[a+1][b-1][c] + EV(transition)) \times P(transition) \\
(dp[a][b+1][c-1] + EV(transition)) \times P(transition) \\
\end{cases}
$$
some notes: 
- $+EV(transition)$ refers to the expected value of operations needed before actually eating the sushi for the transition. This is because there is a chance that we pick an empty plate . If this were not the case, we could have just done $+1$.
- $\times P(transition)$ refers to the probability of switching states. This is required since expected value, is just that, expected. This means that the transition itself should be reduced by the chance of that state actually being reached in the first place. 
j


<iframe width="560" height="315" src="https://www.youtube.com/embed/1HiJ332iZQU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


# Code
---
```cpp
int n;
double state[310][310][310];

double dp(int one, int two, int three)
{
	if(one == 0 and two == 0 and three == 0) return 0.0;
	if(state[one][two][three] != -1) return state[one][two][three];

	double misses = (double) n/ (one+two+three); // EV of tries before actually eating the sushi of this state
	
	double ret = 0.0;
	if(one)
		ret += (dp(one-1,two,three)+misses) * ( (double) one/ (one+two+three) );
	if(two)
		ret += (dp(one+1,two-1,three)+misses) * ((double) two/ (one+two+three) );
	if(three)
		ret += (dp(one,two+1,three-1)+misses) * ( (double)three/ (one+two+three) );

	state[one][two][three] = ret;
	return ret;
}

void solve()
{
	cin >> n; 
	vector<int> inp(n,0);
	vector<int> cnt(4);
	for(int i = 0; i < n; i++)
	{
		cin >> inp[i];
		cnt[inp[i]]++;
	}

	for(int i = 0; i < 310; i++)
	for(int j = 0; j < 310; j++)
	for(int k = 0; k < 310; k++)
		state[i][j][k] = -1;


	double out = dp(cnt[1],cnt[2],cnt[3]);
	cout << fixed << setprecision(10) << out;
}
```