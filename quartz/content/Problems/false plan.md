#bio 
# false plan
---
>[!summary] BIO 2020 problem


# Explanation
---
This is a relatively ok [[combinatorics]] problem which is very similar to a lot of other BIO Q3's like [[parking]], [[modern art]], or [[mystery parcel]].

It is simply [[dynamic programming]] and [[recursion]]

# Code
---
```cpp
ll n;
int p, q, r; 
bool done = false;

//   rec, left
ll dp[13][13];
ll genperms(ll id = 1, int rec=1, string pre="") 
{
	if(done) return 0;
	if(dp[rec][r-pre.length()] != 0 and dp[rec][r-pre.length()] + id < n)
		return dp[rec][r-pre.length()];
	if(pre.length() == r){
		if(rec <= q){
			if(id==n){
				done = true;
				cout << pre << endl;
			}
			return 1;
		}
		return 0;
	}
	if(rec > q) return 0;

	ll tot = 0;
	for(char i = 'A'; i < 'A'+p; i++)
	{
		if(pre.length() and pre.back() == i) {
			tot += genperms(id+tot, rec+1,pre+i);
		}
		else tot += genperms(id+tot, 1,pre+i);
	}
	dp[rec][r-pre.length()] = tot;
	return tot;
}

void solve(int tc)
{
	cin >> p >> q >> r >> n;
	done = false;
	genperms();
}


```