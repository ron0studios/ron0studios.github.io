# sieve of eratosthenes
---
>[!summary] An efficient prime number generator


# Explanation
---
You loop through a [[dynamic programming|DP]] array and, for each factor of a number, set the array value to false. By the end, all true values are primes.
This has a near linear time complexity of $$\pmb{\mathcal{O}(NlogN)}$$
> [!info] 
> this can even be sped up to $\pmb{\mathcal{O}(N\ log\ log\ N)!}$
# Code
---
```cpp
void solve()
{
	// n log log n 
	// second log because of skipping primes, 
	// first log because of the deffered start of the inner loop
	const int n = 10000000;
	vector<bool> prime(n+1,true);
	for(int i = 2; i*i <= n; i++)
	{
		if(!prime[i]) continue;
		for(int j = i*i; j <= n; j += i)
			prime[j] = false;
	}
	for(int i = 0; i <= n; i++)
		if(prime[i])
			cout << i << "\n";
}
```