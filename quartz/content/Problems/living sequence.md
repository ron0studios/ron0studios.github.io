# living sequence
---
>[!summary] Fun codeforces problem


# Explanation
---
This was a pretty tough [[dynamic programming|DP]] [[recursion|recursive]] [[binary search]] problem, that follows a similar style of BIO q3s, requiring the length like [[new order]] or [[upside down]]

This uses the typical style of using [[combinatorics]] to find the different lengths into an intial dp structure, and then determining the length at a certain position $N$. 

You can then use a [[complete search]] method to find the correct string, optimising with a [[dynamic programming|DP]] [[hash map]]. (lots of backlinks here)

> [!info]
> you can also just solve this by switching to base-9 in half the code :P

# Code
---
```cpp

vector<ll> numatlen(14,0);
int len; ll n;
bool done = false;

unordered_map<int, ll> dp;
ll compute(ll pos = 1, string cur="")
{
	if(done) return 0;
	if(cur.length() == len) {
		if(pos == n+1){ 
			cout << cur << endl;
			done = true;
		}
		return 1;
	}

	if(dp.count(cur.length()) and pos+dp[cur.length()] < n) return dp[cur.length()];

	ll out = 0;
	for(char i = '0'; i <= '9'; i++)
	{
		if(i=='4') continue;
		out += compute(pos+out, cur+i);
		if(done) return 0;
	}
	return dp[cur.length()] = out;
}

void solve(int tc)
{
	dp = unordered_map<int, ll>();
	done = false;
	cin >> n;
	len = 0;

	long long tmp_c = 0;
	for(int i = 1; i <= 13; i++)
	{
		tmp_c = numatlen[i];
		if(tmp_c > n) {
			len = i;
			break;
		}
	}

	compute();
}

int main()
{
	numatlen[1] = 9;
	for(int i = 2; i <= 13; i++)
	{
		numatlen[i] = 9;
		for(int j = 1; j < i; j++)
			numatlen[i] += 8*pow(9,j);
	}

    ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    int tc; cin >> tc;
    int ogtc = tc;
    while(tc--)
    {
        solve(ogtc-tc);
    }
    return 0;
}
```