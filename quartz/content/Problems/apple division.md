# apple division
---
>[!summary] A good cses problem for [[complete search#Recursively|recursive complete search]]


# Explanation
---
Since n $\leq$ 20, we can simply just [[Brute force]] this. 

Our state consists of 3 values: an integer $i$, $s1$ and $s2$.

$i$, tracks the index of the current apple in question, whilst $s1$ and $s2$ each track the sum of a split of apples. 

We recurse to a state where $s1$ includes the apple at index $i$ whilst $s2$ doesn't and vice versa, and take the minimum result of it. 

# Code
---
```cpp
int n; 
vector<ll> apples;

ll compute(int i, ll s1,ll s2)
{
	if(i==n) 
	{
		return abs(s1-s2);
	}
	else
	{
		return min(compute(i+1,s1+apples[i], s2), compute(i+1,s1, s2+apples[i]));
	}
}

void solve(int tc)
{
	cin >> n;
	apples = vector<ll>(n,0);
	for(int i = 0; i < n; i++)
		cin >> apples[i];

	cout << compute(0,0,0) << "\n";

}
```