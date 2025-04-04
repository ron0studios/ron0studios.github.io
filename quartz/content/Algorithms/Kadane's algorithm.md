---
aliases:
  - maximum subarray
---

# Kadane's algorithm
---
>[!summary] A [[dynamic programming]] algorithm similar to [[longest increasing subsequence]]


# Explanation
---
This is an algorithm used to find the **maximum subarray** in a list. A *subarray* is a subset of an array where *each element of the subarray must be **contiguous**.* For example in the array `[1,2,3,4,5]`, The array `[1,2,3]` is a valid subarray but `[1,3,5]` is **not**.
[[max subarray sum]]


# Code 
---

## A solution I found
I found this solution before learning about the algorithm. It runs in $\pmb{\mathcal{O}(N)}$ time
```cpp
    int maxSubArray(vector<int>& nums) {

        if(nums.size() == 1){
            return nums[0];
        }
        vector<int> prefix(nums.size(), 0);
        prefix[0] = max(0,nums[0]);
        bool notzero = false;
        for(int i = 1; i < nums.size(); i++){
            prefix[i] = max(0,nums[i] + prefix[i-1]);
            if(!notzero && prefix[i] != 0) notzero = true;
        }

        if(notzero){
            return *max_element(prefix.begin(), prefix.end());
        } else {
            return *max_element(nums.begin(), nums.end());
        }
}
```

## The official algorithm
[Passes leetcode pretty well](https://leetcode.com/problems/maximum-subarray/submissions/1389054124)
```cpp
    int maxSubArray(vector<int>& nums) {

        if(nums.size() == 1){
            return nums[0];
        }

        vector<int> dp(nums.size());
        dp[0] = nums[0];
        for(int i = 1; i < nums.size(); i++){
            if(dp[i-1] < 0){
                dp[i] = nums[i];
            }
            else{
                dp[i] = dp[i-1]+nums[i];
            }
        }
        return *max_element(dp.begin(), dp.end());
    }
```

## memory efficient version of algorithm
Since the only dp transition is to the previous element of the array, we only really need to maintain a dp *variable* rather than an *array*. This beats roughly 75% of solutions on [leetcode](https://leetcode.com/problems/maximum-subarray/submissions/1389057937).
```cpp
    int maxSubArray(vector<int>& nums) {

        if(nums.size() == 1){
            return nums[0];
        }

        int mx = nums[0];
        int prev = nums[0];
        for(int i = 1; i < nums.size(); i++){
            if(prev < 0){
                prev = nums[i];
            }
            else{
                prev = prev+nums[i];
            }
            mx = max(mx, prev);
        }
        return mx;
    }
```


### Alternative (max function)
This gives better results on [leetcode](https://leetcode.com/problems/maximum-subarray/submissions/1389080411). It is also the most **compact** solution i came up with.
```cpp
    int maxSubArray(vector<int>& nums) {
        int mx = nums[0];
        int prev = nums[0];
        for(int i = 1; i < nums.size(); ++i){
            prev = max(0,prev)+nums[i];
            mx = max(mx, prev);
        }
        return mx;
    }
```

