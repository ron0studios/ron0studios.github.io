#bio
# mystery parcel
---
> Very hard BIO 2017 Q3


# Explanation
---
this requires a strong [[combinatorics]] knowledge, similar to [[movie magic]].

Usually, in python, you would use `@lru_cache[maxsize=None]` to do this question in milliseconds ,but c++ does not have that suppoer, therefore [[dynamic programming]] is used instead. 

# Code

v2
```cpp
/* n_parcels: number of parcels
 * n_weights: possible weights from 1 to n_weights
 * n_items: total number of items across all parcels
 * parcel_weight: weight of each parcel (all parcels should weigh the same) */

int n_parcels, n_weights, n_items, parcel_weight;


/*
 * ideas:
 * first permute all the possible parcel item distributions i.e [( 1, 3, 3), (4,1,2), (2,2,3) ...]
 * permute ways of organising items for each parcel
 * multiply?
 */

int dp1[26][26][11];
ll perm_items(int pw, int ni, int nw)
{
	if(pw == 0 and ni == 0) return 1;
	if(pw <= 0 or ni <= 0) return 0;
	if(dp1[pw][ni][nw]) return dp1[pw][ni][nw];

	ll tot = 0;
	for(int i = 1; i <= nw; i++)
	{
		tot += perm_items(pw-i, ni-1, i); // this last argument leads to COMBINATIONS!
	}

	return dp1[pw][ni][nw] = tot;
}

int dp2[6][11][26][26];
ll perm_parcels(int np, int nw, int ni, int pw)
{
	if(np == 0 and ni == 0) return 1;
	if(np <= 0 or ni <= 0 ) return 0;
	if(dp2[np][nw][ni][pw]) return dp2[np][nw][ni][pw];

	ll tot = 0;
	for(int i = 1; i <= ni; i++)
	{
		tot += perm_parcels(np-1, nw,ni-i,pw) * perm_items(pw,i,nw);
	}
	return dp2[np][nw][ni][pw] = tot;
}

void solve()
{
	cin >> n_parcels >> n_weights >> n_items >> parcel_weight;

	cout << perm_parcels(n_parcels, n_weights, n_items, parcel_weight);
	

}
```

v1
```cpp

// number of permutations of each parcel
int item_ways(int w, int n, int max_w){
    if (w == 0 and n == 0)
        return 1;
    if (w <= 0 or n <= 0)
        return 0;
    int ways = 0;
    for (int i = 1; i <= max_w; i++)
        ways += item_ways(w-i, n-1, i);
    return ways;
}   

// total combinations for answer
unordered_map<string,int> dp;
int parcel_ways(int p, int max_w, int n, int w){
    if (p == 0 and n == 0) 
        return 1;
    if (p <= 0 and n <= 0)
        return 0;

	string x; 
	x += char(p); 
	x += char(max_w);
	x += char(n);
	x += char(w);
	
	if(dp[x])
	{
		return dp[x];
	}

    int ways = 0;
    for (int i = 1; i <= n; i++){
        ways += parcel_ways(p-1, max_w, n-i, w) * item_ways(w, i, max_w);
    }
	
	dp[x] = ways;
    return ways;
}

void solve(int tc)
{
	int p,i,n,w; cin >> p >> i >> n >> w;
	cout << parcel_ways(p,i,n,w);
}


```
---