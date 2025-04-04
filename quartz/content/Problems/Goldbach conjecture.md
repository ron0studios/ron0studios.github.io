#bio 
# Goldback conjecture
---
> Question 1 of the 2008 BIO. 


# Explanation
---
use the square root instead of a half to check for primes

# Code
---
```cpp

bool isprime(int x)
{
	for(int i = 2; i <= sqrt(x); i++)
	{
		if(x%i==0)
		{
			return false;
		}
	}
	return true;
}

void solve(int tc)
{
	int x; cin >> x;


	int out = 0;
	for(int i = ceil(x/2); i >= 2; i--)
	{
		if(isprime(i) and isprime(x-i))
		{
			out++;
		}
	}

	cout << out; 

}


```