# sum of two values
---
>[!summary] Surprisingly devious cses problem


# Explanation
---
This problem requires you to use the [[two pointers method]] in order to work for bigger test cases. 

Essentially you sort the array and then maintain a pointer at the beginning and the end of the array. You then [[Greedy|greedily]] move the pointers, when its bigger or less than x until you reach x itself. 

The vector here is a vector of pairs because you are required to output the index of the original array for your answer, and due to the possibility of duplicate numbers, each number in the original array is tagged with its original index (in a pair) before sorting. 


# Code
---
```cpp
void solve()
{
	int n, x; cin >> n >> x;
	vector<pair<int,int>> a;
	for(int i = 0; i < n; i++)
	{
		int y;
		cin >> y;
		a.pb(mp(y,i));
	}


	sort(a.begin(),a.end());
	
	int left = 0;
	int right = n-1;
	while(left < right)
	{
		int sum = a[left].first + a[right].first;
		if(sum < x)
		{
			left++;
		}
		else if(sum > x)
		{
			right--;
		}
		else
		{
			cout << a[left].second+1 << " " << a[right].second+1;
			return;
		}
	}

	cout << "IMPOSSIBLE";

}
```