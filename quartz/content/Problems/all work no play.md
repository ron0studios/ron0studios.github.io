#bio
# all work no play
---
>[!summary] A hard BIO 2009 R2 problem


# Explanation
---
This requires a strong [[dynamic programming]] and [[combinatorics]] knowledge. This is pretty similar to [[ZigZag numbers]], especially **[[new order]]** in terms of *how* it is solved. 

You essentially create a DP [[matrix|grid]] in the form `dp[i][x]`, where `i` is the length of the number and `x` is the sum we want to make. 

Fill that in and you'll have yourself a pascal's triangle, here's what it looks like. 

|     | 0     | 1     | 2     | 3     | 4     |
| --- | ----- | ----- | ----- | ----- | ----- |
| 0   | **1** | **0** | **0** | **0** | **0** | 
| 1   | **0** | **1** | **1** | **1** | **1** |
| 2   | **0** | **0** | **1** | **2** | **3** |
| 3   | **0** | **0** | **0** | **1** | **3** |
| 4   | **0** | **0** | **0** | **0** | **1** |


From there, you simply traverse back from the length of the solution, at the sum we want, to (0,0). 

Here's the tracetable for the example on the question:
```
4,3
3,2
2,1
0,0
```

We know that at (4,3) the 5th to 7th^[inclusive] possibilities exist, and since we want the 5th possibility, we know that the length of our answer will be 3. So we start from (4,3).

From there, we z1

# Code
---
```cpp

void solve(int tc)
{
	int s; ll n;
	cin >> s >> n;

	vector<vector<ll>> dp(s+1, vector<ll>(s+1,0));

	dp[0][0] = 1;
	for(int i = 1; i <= s; i++)
	{
		for(int j = 1; j <= s; j++)
		{
			dp[i][j] = dp[i-1][j-1] + dp[i][j-1];
		}
	}

	// first calculate length of answer
	int len = 1; 
	ll tmpsum = 0;
	while(true) {
		if(tmpsum + dp[len][s] >= n) break;
		tmpsum += dp[len][s];
		len++;
	}

	string out = "";

	ll counter = tmpsum;
	int x, y; 
	x = len-1; y = s-1;

	// traverse dp grid
	while(out.length() < len)
	{
		char choice = '1';
		for(int i = y; i >= 0; i--)
		{
			if(counter + dp[x][i] >= n)
			{
				out += string(1,choice);
				break;
			}
			counter += dp[x][i];

			y--; choice++;
		}
		y--; x--;
	}

	cout << out << endl;

}


```