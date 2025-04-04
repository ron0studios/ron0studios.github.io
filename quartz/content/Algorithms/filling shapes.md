# filling shapes
---
>[!summary] Simple CF problem


# Explanation
---
This is a relatively straightforward [[dynamic programming]] problem. For each 2 columns, there are 2 possibilities:
```
* *      * *
* @  or  @ *
@ @      @ @
```

meaning that:
- If the number of columns is odd, the answer is 0
- If the number of columns is even then the answer is 2^(N/2)


# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	if(n < 2) {
		cout << 0; return;
	}
	vector<int> dp(n+1,0);
	dp[2] = 2;
	for(int i = 3; i <= n; i++)
	{
		dp[i] = 2*dp[i-2];
	}
	cout << dp[n]; 
	
}
```