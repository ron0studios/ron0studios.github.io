#bio 
# fractions
---
> BIO 2005 q1 


# Explanation
---
done using [[Algorithms/Brute force]]
# Code
---
```cpp
// fractions
void solve(int tc)
{
	float x; cin >> x;

	for(float i = 1.0f; i < 10000.0f; i++)
	{
		for(float j = i; j <10000.0f; j++)
		{
			float frac = i/j;
			if(frac==x)
			{
				cout << int(i) << " / " << int(j) << "\n";
				return;
			}
		}
	}

}


```