# Effective approach
https://codeforces.com/problemset/problem/227/B
#implementation

## description
The first, and more obvious, attempt at this problem would be to just simulate the searching of both Vasya and Petya, and output the results. However, this leads to a timeout error, since the size of the arrays can reach 10^5. 
The correct solution is to input the first array as a [[hash map]], so that the indices of every element in the array can be found in **O(1)** time, meaning that we can just figure out how fast a linear scan, say for Vasya, would be by just getting the index of the number (and adding 1, because of 0-based indexing), and for Petya just getting the size of the array and substracting the index. 

## Code
```c++
void solve(int tc)
{
	int n; cin >> n;
	unordered_map<int,int> a; 
	
	// input A as hashmap instead of array
	for(int i = 0; i < n; i++)
	{
		int x; cin >> x;
		a[x] = i;
	}
	
	int m; cin >> m;
	vector<int> b; inveci(m,b)
		
		
	//Vasya. 
	long long c1 = 0;
	for(auto i : b)
	{
		c1 += a[i]+1;
	}

	//petya
	long long c2 = 0;
	for(auto i : b)
	{
		c2 += n-a[i];
	}
	cout << c1 << " " << c2 << "\n";
}
```