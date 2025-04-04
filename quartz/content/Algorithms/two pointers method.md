# two pointers method
---
> [!info] a useful method for sorting and searching

## merging
---
>[!summary] An algorithm for merging two sorted arrays in **O(N)** time^[much faster than the traditional **Nlog(N) method**]

```cpp

void solve()
{
	int n1; cin >> n1; 
	vector<int> a; inveci(n1,a);
	int n2; cin >> n2; 
	vector<int> b; inveci(n2,b);

	vector<int> c; // (out)
	// two pointers
	int i = 0; int j = 0; // pointers
	while(i < a.size() || j < b.size())
	{
		if(j >= b.size() or (i < a.size() and a[i] < b[j]))
		{
			c.pb(a[i]);
			i++;
		}
		else
		{
			c.pb(b[j]);
			j++;
		}
	}
	for(auto i : c)
		cout << i << " ";
}


```

