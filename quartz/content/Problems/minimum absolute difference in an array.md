# minimum absolute difference in an array
---
>[!summary] conventional hackerrank problem


# Explanation
---
This problem at first glance, looks like it could be [[Brute force|brute forced]], however, test cases can reach up to 100,000 which yields that algorithm inefficient. 

A better solution is to sort the algorithm in $Nlog(N)$ time and run through the differences between each element, in a [[Greedy]] fashion.

# Code
---
```cpp
int minimumAbsoluteDifference(vector<int> arr) {
	sort(arr.begin(),arr.end());
	int out = INT_MAX;
	for(int i = 1; i < arr.size(); i++)
	{
		out = min(out, abs(arr[i]-arr[i-1]));
	}
	return out;
}
```