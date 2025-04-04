# Counting Sort
> A special [[sorting|sorting algorithm]] that runs **less than O(nlogn)**


# Explanation
Essentially what counting sort is doing is that it is forming an array in which we have our starting indexes for any given index i. Shifting everything to the right simply makes this applicable for 0 based indexing. 
This algorithm is very useful when operating on data structures that have a very low range. 

# Time complexity
The time complexity of Counting Sort is $O(N+R)$ where $R$ is the range of values in the array. 

# Code
```c++
void solve(int tc)
{
	int n; cin >> n;
	vector<int> a;
	vector<int> count(n+1,0);
	vector<int> countacc(n+2,0);
	vector<int> output(n,-1);

	for(int i = 0; i < n; i++)
	{
		int x; cin >> x;
		a.pb(x);
		count[x]++;
	}
	

	int acc = 0;
	for(int i = 0; i <= n; i++)
	{
		acc += count[i];
		countacc[i+1] = acc;
	}

	for(auto i : a)
	{
		int start = countacc[i]; 
		output[start] = i;
		countacc[i]++;
	}

	for(auto i : output)
	{
		cout << i << " ";
	}

	cout << "\n";
}
```