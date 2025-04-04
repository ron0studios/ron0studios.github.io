# merge sorted array
---
>[!summary] leetcode 88. SImple but neat problem. took 20 mins


# Explanation
---
At very first glance it might seem like this would need a [[two pointers method|two pointers]] approach and, whilst this problem could theoretically be solved in this manner, it would be very tedious and miss out on a load of edge cases.

Instead, a much simpler solution would be to use a modified version of [[insertion sort]]. Since this algorithm is [[online]], you can just start from element `m` (the last element of `arr1`), and insert the first element of `arr2`, and **"insert"** it into its correct spot in arr1. 

 For the leetcode problem, specifically, they provide zero-ed empty slots at the end of `arr1` which is indicative of this being the correct approach. 

The algorithm fashions a very optimal $\pmb{\mathcal{O}(N)}$ time complexity and $\pmb{\mathcal{O}(1)}$ space complexity. 

# Code
---
here is my [solution](https://leetcode.com/problems/merge-sorted-array/submissions/1412500033)
```cpp
void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
	for(int i = m; i < m+n; i++) {
		nums1[i] = nums2[i-m];
		
		int j = i;
		while(j && nums1[j] < nums1[j-1]){
			swap(nums1[j], nums1[j-1]);
			j--;
		}
	}
}
```