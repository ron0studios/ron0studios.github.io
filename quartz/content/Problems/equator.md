# equator
---
>[!summary] Easy CF problem, over-rated (1300), should be 800-900


# Explanation
---
easy [[ad hoc]]

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	int sum = 0;
	vector<int> schedule(n,0);
	for(int i = 0; i < n; i++)
	{
		cin >> schedule[i];
		sum += schedule[i];
	}

	int tot = 0;
	for(int i = 0; i < n; i++)
	{
		tot += schedule[i];
		if(tot >= (float)sum/2)
		{
			cout << i+1; return;
		}
	}
}
```