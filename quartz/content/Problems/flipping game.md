# flipping game
---
>[!summary] Easy codeforces problem


# Explanation
---
This is a simple [[complete search]] problem where you loop through all the valid pairs.

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> a(n,0); 
	for(int i = 0; i < n; i++)
		cin >> a[i];
	
	int sum = 0;
	for(auto i : a)
		sum+=i;
	int max1 = 0;
	

	for(int i = 0; i < n; i++)
	{
		for(int j = i; j < n; j++)
		{
			int newsum = sum;
			for(int k = i; k <= j; k++)
			{
				if(a[k] == 0)
					newsum++;
				else
					newsum--;
			}
			max1 = max(newsum,max1);
		}
	}
	cout << max1;
}
```