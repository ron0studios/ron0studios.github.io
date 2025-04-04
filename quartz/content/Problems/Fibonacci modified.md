# Fibonacci modified
---
>[!summary] 
>A pretty easy [[dynamic programming]] problem with a bit of a problem


# Explanation
---
Its *literally* just fibonacci, but the numbers get too big so I used python instead to submit.

# Code
---
```cpp
int fibonacciModified(int t1, int t2, int n)
{
	vector<ll> dp(n+2,0);
	dp[0] = t1;
	dp[1] = t2;
	for(int i = 2; i <= n; i++)
	{
		dp[i] = dp[i-2] + pow(dp[i-1],2);
	}
	return dp[n-1];
}
```
```python
def fibonacciModified(t1, t2, n):
    dp = [0]*(n+1)
    dp[0], dp[1] = t1,t2
    for i in range(2,n+1):
        dp[i] = dp[i-2] + dp[i-1]**2
    return dp[n-1]
```