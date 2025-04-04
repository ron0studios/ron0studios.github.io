# great sequence
---
>[!summary] A relatively ok codeforces problem


# Explanation
---
This problem is a simple [[Greedy]] + [[Brute force]] problem that requires some shortcuts to get right for all testcases.

The solution is to first [[sorting|sort]]^[recommended but not required] the array, and then for every number in the list, find the number that ,when divided by x, makes the same element. This solution works, but is too slow for big test cases, because of the double loops.

A better solution is to use a [[hash map]] to store a count of every number and then substract the counts every time a valid pair, or set of pairs is found. For example, if $x=2$, and the counts were stored like `{1:12, 2:10, 4:5}`, then you would go to the first number, 1, and find that you can make 5 pairs, with 1 and 2, (1 times 2 is 2). that leaves us with 2 ones and zero twos. This means that 2 new twos have to be created in order to finish off the rest of the ones, so the total is incremented by 2. 
There are now 0 twos, and therefore we skip that element and go onto 4, which there are 5 of, but no 8s, so we increment the total by 5.

# Code
---
```cpp
#include "bits/stdc++.h"

using namespace std;

#define mp make_pair
#define pb push_back
#define INF (int)1e9
#define EPS 1e-9
#define PI 3.1415926535897932384626433832795
#define MOD 1000000007
#define ll long long
#define v(i) vector<i>
#define inveci(n,a) for(int integer=0; integer < n; integer++) {int abc123; cin >> abc123; a.pb(abc123);}
typedef unsigned int uint;
template <typename T,typename U>                                                   
std::pair<T,U> operator+(const std::pair<T,U> & l,const std::pair<T,U> & r) {   
    return {l.first+r.first,l.second+r.second};                                    
}


void solve(int tc)
{
	ll n,x; cin >> n >> x;
	vector<ll> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];
	sort(a.begin(),a.end());

	map<ll,ll> cnt;
	for(int i = 0; i < n; i++)
		cnt[a[i]]++;


	ll out = 0;
	for(auto i : cnt)
	{
		ll num = i.first;
		ll mult= i.first*x;

		if(not cnt.count(mult) or cnt[mult] == 0)
		{
			out += i.second;
			cnt[num] = 0;
		}
		else
		{
			if(cnt[num] > cnt[mult])
			{
				cnt[num] -= cnt[mult];
				cnt[mult] = 0;
				out += cnt[num];
			}
			else
			{
				cnt[mult] -= cnt[num];
				cnt[num] = 0;
			}
		}
	}

	cout << out << endl;
}
```