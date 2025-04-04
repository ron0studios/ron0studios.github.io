# block adventure
---
>[!summary] A pretty ok codeforces problem


# Explanation
---
This is a pretty straightforward [[Greedy]] problem.

The solution is to just take as many blocks as possible until you reach the lower bound^[when taking any more blocks would mean you'd have to start placing blocks to be within $k$]. 

# Code
---
```cpp
void solve(int tc)
{
	int n, bag, k; cin >> n >> bag >> k;
	vector<int> blocks(n, 0);
	for(int i = 0; i < n; i++)
		cin >> blocks[i];
	
	int pos = 0;
	while(pos < n-1){
		int cur = blocks[pos];
		int lower = max(0, blocks[pos+1]-k);
		
		if(cur >= lower)
		{
			bag += cur-lower;
		}
		else
		{
			bag -= lower-cur;
			if(bag < 0)
			{
				cout << "NO\n"; return;
			}
		}
		
		pos++;
	}

	cout << "YES\n";

}
```