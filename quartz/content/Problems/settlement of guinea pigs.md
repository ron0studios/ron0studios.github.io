# settlement of guinea pigs
---
>[!summary] Cringe CF problem


# Explanation
---
This is a tough [[Greedy]] problem, mainly because of how terribly explained the problem statement is. The best way to go about is to imagine the genders of all the guinea pigs to be in a superposition that collapses when you see the doctors^[yes...].  So you should take the worst possible case for the genders. This usually means having one more of one gender than the other, so you end up with one of each left over. 

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<int> b(n,0);
	for(int i = 0; i < n; i++){
		cin >> b[i];
	}

	int full = 0;
	int half = 0;
	int empty = 0;
	for(int i = 0; i < n; i++)
	{
		if(b[i] == 1)
		{
			if(empty)
				empty--;
			half++;
		}
		else
		{
			int tot = full+half+empty;
			int fem = (half-(half%2))/2;
			int mal = ((half-(half%2))/2)+(half%2);

			if(fem and mal and (fem%2==0) and (mal%2==0))
			{
				fem++; mal--;
			}
			full += floor((float)fem/2.0);
			full += floor((float)mal/2.0);

			half = (fem%2)+(mal%2);
			empty = tot-full-half;
		}
	}

	cout << full+half+empty << endl;

}
```