# mali
---
>[!summary] kattis-mali. A fun [[sorting]] and [[Greedy]] problem. Took around 1 hour


# Explanation
---
This problem makes use of [[counting sort]] to perform an *online* sort of incoming input. After that it is simply a [[Greedy]] match between the largest and smallest values in either array.
# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> ac(101, 0);
	vector<int> bc(101, 0);
	int mxb = -1, mxa = -1;
	vector<int> tmpa, tmpb;
	for(int i = 0; i < n; i++){
		int a,b; cin >> a >> b;
		ac[a]++;
		bc[b]++;
		mxa = max(mxa, a);
		mxb = max(mxb, b);
		tmpa = ac;
		tmpb = bc;
		
		
		int aptr = 1, bptr = 100;
		int out = -1;
		for(int j = 0; j < i+1; j++){
			while(not ac[aptr]) aptr++;
			while(not bc[bptr]) bptr--;
			if(aptr > 100 or bptr < 1) break;
			out = max(out, aptr+bptr);
			int subs = min(ac[aptr], bc[bptr]);
			ac[aptr] -= subs;
			bc[bptr] -= subs;
		}
		ac = tmpa;
		bc = tmpb;
		cout << out << endl;
	}
}
```

(shortened solution for kattis leaderboard)
```cpp
#include "bits/stdc++.h"
#define v vector<int>
#define l(x,n) for(x=0;x<n;++x)
using namespace std;int main(){int n,a,b,ap,o,bp,s,i,j;cin>>n;v ac(101,0),bc(101,0),ta,tb;l(i,n){cin>>a>>b;ac[a]++,bc[b]++,ta=ac,tb=bc,ap=1,bp=100,o=-1;l(j,i+1){while(!ac[ap])ap++;while(!bc[bp])bp--;if(ap>100||!bp)break;o=max(o,ap+bp);s=min(ac[ap],bc[bp]);ac[ap]-=s;bc[bp]-=s;}ac=ta,bc=tb;printf("%i\n",o);}}

```