#bio
# New order
---
> A q3 from the 2003 BIO


# Explanation
---
this is an interesting [[dynamic programming]] problem requiring a [[matrix]]. 

pretty similar to other "find the n'th" problems, like [[modern art]], or [[all work no play]], except its harder because it uses a weird pattern with a lot of possible edge cases.

# Code
---
```cpp

void solve(int tc)
{
	int n, m; cin >> n >> m;
	if(m == 0)
	{
		cout << "0" << endl;
		return;
	}
	// find length first
	vector<vector<ll>> dp(31, vector<ll>(31,0) );
	dp[0][0] = 1;
	for(int i = 1; i <= 30; i++)
	{
		for(int j = 1; j <= i; j++)
		{
			dp[i][j] = dp[i-1][j] + dp[i-1][j-1];
		}
	}


	ll combs = 0;
	int len = m-1;
	for(int j = m; j <= 30; j++)
	{
		if(combs >= n)
		{
			break;
		}
		combs += dp[j][m];
		len++;
	}
	combs -= dp[len][m];

	string out = "1";
	int left = len-1;
	m--;

	while((int)out.length() < len)
	{
		ll choose0 = combs+dp[left-1][m];
		ll choose1 = combs+dp[left-1][m-1];
		if(choose0 >= n or m==0)
		{
			out += "0";
			left--;
		}
		else
		{
			out += "1";
			left--;
			m--;
			combs += choose0-combs;
		}
	}

	cout << out << endl;

}


```