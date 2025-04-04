---
aliases: 
date: 
time taken (mins):
---


# Compass walking
---
>[!summary] Simple atcoder problem. took 5 mins


# Explanation
---
simply devide the length of $(x,y)$ with R and the ceiling should be the answer.

> [!warning] there is an edge case where if $R<|(x,y)|$ then the jumps needed is **2**

# Code
---
```cpp
void solve()
{
	ll r,x,y; cin >> r >> x >> y;


	long double d = sqrtl(powl(x,2)+powl(y,2));
	if(d<r) {
		cout << 2; return;
	}

	cout << ceill(d/r);

}
```