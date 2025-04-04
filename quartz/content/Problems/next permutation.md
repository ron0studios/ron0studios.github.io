# next permutation
---
>[!summary] leetcode 31. Interesting [[combinatorics]] problem. Took around 1-2 hours


# Explanation
---
The approach to take here is [[Greedy]]. What we need to do is, starting from the right, find the first element, $Arr_i$ that has *at least* one element, $Arr_j$ greater than it located to the right. For example if the array was `[2,6,3,5,4,1]`, the first detected element would be `3` at index `2`^[0-based indexing].   

If there are multiple values for $Arr_j$, we select the smallest one. We then proceed to *swap* $Arr_i$ and $Arr_j$, and [[sorting|sort]] elements in the array to the right of $Arr_i$ (before the swap). 
# Code
---
```cpp
void nextPermutation(vector<int>& nums) {
	for(int i = nums.size()-1; i >= 0; i--){
		int closest = INT_MAX;
		int idx = -1;
		for(int j = i+1; j < nums.size(); j++){
			if(nums[j] > nums[i] && nums[j]-nums[i] < closest){
				closest = nums[j] - nums[i];
				idx = j;
			}
		}

		if(idx == -1) continue;

		if(idx > i){

			swap(nums[idx], nums[i]);
			sort(nums.begin()+i+1, nums.end());
			return;
		}
	}
	reverse(nums.begin(), nums.end());
}
```