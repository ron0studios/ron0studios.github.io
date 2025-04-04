# sleepy cow sorting
---
>[!summary] A slightly twisty [[ad hoc]] usaco problem


# Explanation
---
The main observation to make here, is that if the last $i$ elements of the sequence are already increasing, then the all there is left to sort is the first $n-i$ elements. 
For example:
$$3,1,2,4$$
has 3 elements of increasing order at the end (`1,2,4`), meaning the element needed to be sorted is 3, hence the answer is *1*. 

# Code
---
```cpp
void solve()
{
	freopen("sleepy.in","r",stdin);
	freopen("sleepy.out","w",stdout);

	int n; cin >> n;
	vector<int> cows(n,0);
	for(int i = 0; i < n; i++)
		cin >> cows[i];

	if(is_sorted(cows.begin(),cows.end()))
	{
		cout << 0; return;
	}

	int max_unsorted = 1;
	for(int i = n-1; i > 0; i--)
	{
		if(cows[i] > cows[i-1])
		{
			max_unsorted++;
		}
		else
			break;
	}
	
	cout << n-max_unsorted;
}
```