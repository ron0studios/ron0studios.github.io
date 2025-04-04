# sleepy cow herding
---
>[!summary] pretty easy [[ad hoc]] usaco problem


# Explanation
---
Two key observations needed:
- The minimum moves is either 2 or 1
- The maximum moves is just the maximum space between any two consecutive cows.

# Code
---
```cpp

void solve()
{
	freopen("herding.in","r",stdin);
	freopen("herding.out","w",stdout);
	vector<int> cows(3,0);
	cin >> cows[0] >> cows[1] >> cows[2];
	sort(cows.begin(),cows.end()); // the input might not be in increasing order

	int min_dist = min(cows[1]-cows[0], cows[2]-cows[1]);
	int max_dist = max(cows[1]-cows[0], cows[2]-cows[1]);

	if(cows[0] + 1 == cows[1] and cows[1]+1 == cows[2])
	{
		cout << 0 << "\n" << 0;
		return;
	}

	// line 1 output
	if(min_dist == 2)
		cout << 1 << "\n";
	else
		cout << 2 << "\n";

	// line 2 output
	cout << max_dist - 1 << "\n";

}


```