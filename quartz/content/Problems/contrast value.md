# contrast value
---
>[!summary] Pretty easy CF problem


# Explanation
---
this is a [[Greedy]] problem that can be solved by visualising the numbers as valleys or hills. For example 1 2 3 4 5 6 can be simply reduced to 1 6, but 5 4 3 2 3 4 5 cannot be reduced to 5 5, it must be reduced to 5 2 5. This means we have to find peaks and troughs in the number sequence and the total number is our answer.

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<int> a;
	for(int i = 0; i < n; i++){
		int x; cin >> x;
		if(!a.empty() and x==a.back()) continue;
		a.pb(x);
	}
	n = a.size();

	/*
	for(auto i : a)
		cout << i << ", ";
	cout << endl;
	*/

	int contrast = 0; 
	for(int i = 1; i < n; i++)
		contrast += abs(a[i]-a[i-1]);
	
	if(!contrast) {
		cout << 1 << endl;
		return;
	}

	if(n==2){
		cout << 2 << endl;
		return;
	}

	vector<int> b = {0};
	for(int i = 2; i < n; i++)
	{
		if(i+1==n)
		{
			if(a[i] > a[i-1] or a[i-1] > a[i])
				b.pb(i);
		}
		if((a[i]-a[i-1] > 0 and a[i-1]-a[i-2] < 0) or (a[i]-a[i-1] < 0 and a[i-1]-a[i-2] > 0))
			b.pb(i-1);
	}

	/*
	for(auto i : b)
		cout << i << " ";
	cout << endl;
	*/

	cout << b.size() << endl; 
}
```