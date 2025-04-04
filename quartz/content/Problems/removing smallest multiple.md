# removing smallest multiple
---
>[!summary] fun codeforces problem


# Explanation
---
This is a pretty alright [[Greedy]] problem.
All you got to do is go through the S set and every time T equals 0 at a certain index, you'll immediately invoke the remove operation on that multiple, as its the cheapest one possible to remove that element. After that you check all the other multiples from that element onwards, and see if in those cases that T[i]also equals 0, doing the same thing^[with the initial cost k, not the bigger one at the multiple itself].  during this multiple checking cycle, we'll break out early if T[i] = 1, because then we'd end up removing an element that's supposed to stay in T. 

Continue this procedure for all elements in T and you should be done. 

This is similar to the [[sieve of eratosthenes]], because of the multiple checking thing.

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<int> t(n,0);
	vector<int> s(n,1);
	ll cost = 0;

	string tmps; cin >> tmps;
	for(int i = 0; i < n; i++){
		t[i] = tmps[i]-'0';
	}

	for(int i = 0; i < n; i++)
	{
		if(t[i] == 0)
		{
			int j = i;
			int mult = i+1;
			while(j < n){
				if(t[j] == 0 and s[j]){
					s[j] = 0;
					cost += i+1;
				}

				if(t[j] == 1) break;

				j += mult;
			}
		}
	}
	cout << cost << endl;
}
```