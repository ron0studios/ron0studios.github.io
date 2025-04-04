#bio
# increasing passwords
---
>[!summary] Hard BIO problem

# Explanation
---
> [!warning] ngl idk how i solved this i just did guesswork

this is basically [[all work no play]] but its in reverse for the columns, where each column refers to the starting character, given a length.


# Code
---
```cpp

string options = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

void solve()
{
	ll n; cin >> n;

	ll dp[37][37];
	
	dp[0][0] = 1;

	for(int i = 1; i <= 36; i++)
	{
		for(int j = 1; j <= 36; j++)
		{
			dp[i][j] = dp[i-1][j-1] + dp[i][j-1]; // binomial
		}
	}

	ll tmp_c = 0;
	pair<int,int> pos;
	for(int i = 1; i <= 36; i++)
	{
		bool done = false;
		for(int j = 36; j > 0; j--)
		{
			tmp_c += dp[i][j];
			if(tmp_c >= n)
			{
				pos = mp(i,j);
				done = true;
				break;
			}
		}
		if(done) break;
	}
	
	string out = string(1, options[36-pos.second]);
	int len = pos.first;
	ll counter = tmp_c - dp[pos.first][pos.second];

	while(out.length() < len)
	{
		for(int i = pos.second-1; i >= 0; i--)
		{
			counter += dp[pos.first-1][i];
			if(counter >= n)
			{
				out += string(1,options[36-i]);
				counter -= dp[pos.first-1][i];
				pos = mp(pos.first-1, i);
				break;
			}
		}
	}
	cout << out << endl;

}


```