# line
---
>[!summary] interesting cf problem


# Explanation
---
This is a pretty straightforward [[Greedy]] problem. Essentially, you pick the closest incorrect-facing person to switch at each step. 
An incorrect-facing person is someone who's facing left on left half of the line or right on the right half of the line
The *closest* person refers to the person closest to either end of the line. 

> [!warning]
> careful with how you deal with `long long`! All numbers in a `long long` function must also have the `long long` type! For example the variable `out` in the `calcsum(string s)` function

# Code
---
```cpp

long long calcsum(string s)
{
	long long out = 0;
	for(int i = 0; i < s.size(); i++)
	{
		if(s[i] == 'R')
		{
			out += s.size()-i-1;
		}
		else
		{
			out += i;
		}
	}
	return out;
}

void solve(int tc)
{
	int n; cin >> n;
	string s; cin >> s;
	// greedy to middle


	ll sm = calcsum(s);
	//cout << sm << "\n\n\n\n";

	int fromleft = 0;
	int fromright = n-1;
	bool done = false;
	for(int k = 0; k < n; k++)
	{
		if(done)
		{
			cout << sm << " ";
			continue;
		}
		int wrongleft = -1;
		int wrongright = -1;

		for(int i = fromleft; i < floor(n/2); i++)
		{
			if(s[i] == 'L')
			{
				wrongleft = i;
				fromleft = i;
				break;
			}
		}

		for(int i = fromright; i >= ceil(n/2); i--)
		{
			if(s[i] == 'R')
			{
				wrongright = i; 
				fromright = i;
				break;
				
			}
		}

		if(wrongleft == -1 and wrongright == -1)
		{
			cout << sm << " ";
			done = true;
			continue;
		}

		if(wrongleft < (n-1)-wrongright and wrongleft != -1)
		{
			s[wrongleft] = 'R';
			ll before = wrongleft;
			ll after  = n - wrongleft - 1;
			sm += after-before;
		}
		else
		{
			s[wrongright] = 'L';
			ll before = n - wrongright - 1;
			ll after = wrongright;
			sm += after - before;
			//cout << before << ":" << after << "\n";
		}

		//sm = calcsum(s);
		//cout << s << "\n";
		cout << sm << " ";
	}
	cout << "\n";

}
```