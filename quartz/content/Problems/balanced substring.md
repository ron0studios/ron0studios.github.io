# balanced substring
---
>[!summary] HARD codeforces [[dynamic programming|DP]] problem


# Explanation
---
This problem requires knowledge on using a [[prefix sum]] and [[dynamic programming|DP]].  

Essentially, first you have to create 2 [[prefix sum|prefix sums]]. One for the number of ones and another for the number of zeroes in the string.

Once you've done that, create an array called "balance" which is equal to `ones[i] - zeros[i]`. The number at each index will tell you how many ones or zeroes "off" the prefix is from a perfect balance.  

If you can find another point to the left of a point in the array that has the same value, then you know for certain that the imbalance is in that particular prefix. Therefore, more precisely `[first+1,last]` will be a valid substring, if `balance[last] = balance[first]`^[we do `first+1`, because we want to exclude the entire [0,first] substring].

Now what we have to do is to solve a different problem. What is the largest distance between 2 numbers of the same value in the `balanced` array?

The way we do this is using [[dynamic programming|DP]]. Where we create a [[hash map]] that stores the minimum index for every balance value. All we do now is loop through the balanced array, storing/updating the hashmap for each index, and then checking `i-hashmap_min_index[i]` for the size of the substring, and finding the longest length. 

Look at [[the maximum subarray]] problem for a similar kind of problem, (easier)


# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	string s; cin >> s;

	vector<int> ones(n,0);
	vector<int> zeros(n,0);
	vector<int> balance(n,0);
	unordered_map<int,int> minindex; //(n,INT_MAX);
	minindex[0] = -1;
	int out = -1;

	for(int i = 0; i < n; i++)
	{
		ones[i] = ones[max(0,i-1)];
		zeros[i] = zeros[max(0,i-1)];
		if(s[i] == '1') 
			ones[i] = ones[max(0,i-1)] + 1;
		else
			zeros[i] = zeros[max(0,i-1)] + 1;

		balance[i] = zeros[i]-ones[i];

		if(minindex.count(balance[i]))
			minindex[balance[i]] = min(minindex[balance[i]], i);
		else
			minindex[balance[i]] = i;

		out = max(out, i-minindex[balance[i]]);
	}
	
	cout << out;
}
```