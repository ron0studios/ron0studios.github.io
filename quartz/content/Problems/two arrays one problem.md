# two arrays one problem
---
>[!summary] A pretty interesting Yotta problem 
>https://codeforces.com/gym/449001


# Explanation
---
This problem is an interesting combo of [[selection sort]] and the [[prefix sum]]. 

The key realisation is that when you select a segment $[a,b]$ to run an operation on,  the items at $pref[a-1]$ and $pref[b]$ get swapped. Therefore we have reduced it to a problem of converting from array $prefA$ to $prefB$, i.e the [[prefix sum|prefix sums]] of array A and B, with the minimum number of swaps, which we can do with [[selection sort]]. 

> [!warning] avoid hashmaps in this scenario!
> there is a risk that some of the testcases in this problem exploit the worst case scenario of a hashmap.
>  https://codeforces.com/blog/entry/62393  

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<ll> a(n,0);
	vector<ll> b(n,0);
	for(int i =0 ; i < n; i++)
		cin >> a[i];
	for(int i =0 ; i < n; i++)
		cin >> b[i];

	vector<ll> p1(n,0); p1[0] = a[0];
	vector<ll> p2(n,0); p2[0] = b[0];

	for(int i = 1; i < n; i++)
	{
		p1[i] = p1[i-1] + a[i];
		p2[i] = p2[i-1] + b[i];
	}

	map<int,int> apos;
	vector<ll> p1sort = p1; sort(p1sort.begin(),p1sort.end());
	vector<ll> p2sort = p2; sort(p2sort.begin(),p2sort.end());
	for(int i = 0; i < n; i++){
		apos[p1[i]] = i;
	}


	if(p1sort != p2sort)
	{
		cout << "-1\n";
		return;
	}

	int swaps = 0;
	// basically selection sort
	for(int i = 0; i < n; i++)
	{
		int target = p2[i]; 
		int source = apos[target];
		int sink = p1[i];
		

		if(source == i) continue;

		// swap
		p1[i] = target;
		p1[source] = sink;
		apos[target] = i;
		apos[sink] = source;
		swaps++;
	}

	cout << swaps << "\n";

}


```