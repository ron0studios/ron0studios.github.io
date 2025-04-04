#bio
# Distinct prime factorisation
---
> Pretty alright BIO 2011 Q1


# Explanation
---
you just [[Brute force]] it

# Code
---
```cpp

unordered_map<int,bool> primes; 

// check prime
bool check(int n)
{
	if(primes[n]) return true; 
	if(n < 2) return false;
	for(int i = 2; i < n; i++) 
	{
		if( n % i == 0)
			return false;
	}
	primes[n] = true;
	return true;
}

void solve(int tc)
{
	primes[2] = true;
	int x; cin >> x;
	unordered_map<int,bool> factors;

	while(true)
	{
		if(x < 2) break;
		for(int i = 2; i<=x; i++)
		{
			if(check(i) and x % i == 0){
				x /= i;
				factors[i] = true;
				break;
			}
		}
	}

	int product = 1;
	for(auto i : factors)
	{
		product *= i.first;
	}
	cout << product << "\n";
}


```