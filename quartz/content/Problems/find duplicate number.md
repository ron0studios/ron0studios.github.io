# find duplicate number
---
>[!summary] Leetcode 287. Ultra easy to find a memory inefficient solution. took 5 mins to find solution 1. I found a very cool simpleer solution after another 10 mins


# Explanation
---
Essentially what you can do is a simplified version of the [[Floyd's TH algorithm]], where you just need to traverse a [[graph]] of the nums array, where `nums[i]` is an *edge* taking node `i` to node `edge[i]`. Starting from `i=0` we set the value of the current node to 0 and travers to `node[i]`, until we find a node that is set to 0^[the input constrains the value of `nums[i]` to be **strictly** greater than 0, so we can do this safely]. 

As an addendum, the inefficient solution is to literally maintain an array of bools, and loop through the array, toggling the bools and checking if any of them are *already* toggled. 
# Code
---
### memory inefficient solution
[here](https://leetcode.com/problems/find-the-duplicate-number/submissions/1412590147)
```cpp
int findDuplicate(vector<int>& nums) {
	vector<int> chk(nums.size(), 0);
	
	for(int i = 0; i < nums.size(); i++){
		if(chk[nums[i]-1]) return nums[i];
			chk[nums[i]-1] = 1;
		}
	return -1;
}
```

### memory *efficient* solution
[here](https://leetcode.com/problems/find-the-duplicate-number/submissions/1412593927)
```cpp
    int findDuplicate(vector<int>& nums) {
        int ptr = 0;
        while(nums[ptr]){
            int x = nums[ptr];
            nums[ptr] = 0;
            ptr = x;
        }
    }
```

