#bio
# Drats
---
> A very weird sort of [[dynamic programming]] problem in the 2006 BIO


# Explanation
---
dynamic programming is actually not needed for this problem, just a ton of restraints in the recursion. The recursive solution is a clone of [[coin change]].
> [!info] update 28/11/22
>  lmao that was a lie, [[dynamic programming]] is essential, this is basically and [[Coin Change]] with the first row being doubled


# Code
---
better, shorter, crisper solution
```cpp
void solve(int tc)
{
	int score, drats; cin >> score >> drats;
	
	vector<vector<ll>> dp(9, vector<ll>(201,0));
	dp[0][0] = 1;
	for(int i = 1; i <= 8; i++)
	{
		for(int j = 1; j <= 200; j++)
		{
			for(int k = 1; k <= 20; k++)
			{
				int s = k;
				if(i==1) s *= 2;
				if(j-s < 0) continue;
				dp[i][j] += dp[i-1][j-s];
			}
		}
	}

	cout << dp[drats][score] << endl;
}
```

old solution
```cpp

vector<int> coins(20);
map<int,int> dp;

int compute(int score, int d, int depth = 0) 
{
	if(score < 0) return 0;
	if(depth > d) return 0;
	if(score == 0 and depth == d){
		return 1; 
	}
	if(depth==d)
	{
		return 0;
	}

	if(dp[score] and depth == d) return 1;


	int out = 0;
	for(auto i : coins)
	{
		if(depth == 0) i*=2;
		out += compute(score-i,d,depth+1); 
	}

	return dp[score] = out;
}

// drats
// this is basically coin change
void solve(int tc)
{
	iota(coins.begin(),coins.end(),1); 
	dp[0] = 1;
	int score, drats; cin >> score >> drats;
	cout << compute(score,drats) << endl;
	for(auto i : dp)
	{
		cout << i.second << " ";
	}
	cout << endl;
}


```