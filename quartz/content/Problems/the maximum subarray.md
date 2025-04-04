# the maximum subarray
---
>[!summary] hackerrank problem


# Explanation
---
This is a combination of [[longest increasing subsequence]] and [[max subarray sum]]. The main difference is that, instead of a "longest" increasing subsequence, its just the largest subset of the array. 

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> arr(n,0);
	for(int i = 0; i < n; i++)
		cin >> arr[i];
		
	// max subsequence
	int max_subseq = -1;
	vector<int> dp(n,0);
	int mxidx = 0;
	for(int i = 0; i < n; i++)
	{
		dp[i] = max(dp[mxidx]+arr[i],arr[i]);
		if(dp[i] > dp[mxidx])
			mxidx = i;
	}
	max_subseq = dp[mxidx];
	
	// max subarray
	int max_subarr = -1;
	vector<int> prefix(n+1,0);
	// calculate prefix sum
	for(int i = 1; i <= arr.size(); i++)
	{
		prefix[i] = prefix[i-1] + arr[i-1];
	}
	
	int min_prefsum = prefix[0];
	int max_prefsum = prefix[1];
	for(int i = 1; i <= arr.size(); i++)
	{
		max_prefsum = max(prefix[i]-min_prefsum,max_prefsum);
		min_prefsum = min(prefix[i],min_prefsum);
	}
	max_subarr = max_prefsum;
	
	//return {max_subarr, max_subseq};
	cout << max_subarr << " " << max_subseq << endl;
}
```