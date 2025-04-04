---
aliases:
  - sort an array of 0s 1s and 2s
---

# Sort colors^[ew american spelling]
---
>[!summary] Leetcode 75. This is a simple but fun [[sorting]] problem. Took around 10 minutes.


# Explanation
---
This problem may be reminiscent of [[counting sort]], in the fact that the number of unique elements to sort is limited (only 3 different colours). However, the question has a **strict** memory limit of $\pmb{\mathcal{O}(1)}$, which is infeasible since counting sort has a space complexity of $\pmb{\mathcal{O}(N)}$. 

Instead, we will be using something very similar to **[[Algorithms/insertion sort]]**, in that we need to loop through the array and *insert* the element to a partially sorted subarray to the left.

However, unlike in a typical insertion sort algorithm where you need to shuffle an element one by one until it finds its correct spot, we actually only need to do a maximum of **2 swaps**. This is because we already know there are only 3 unique elements, meaning we can maintain 3 **pointers** to a *frontier* for each type of element, 0, 1 and 2^[By a **frontier** we mean a variable storing the *index* of the rightmost element in the partially sorted array containing 0,1, and 2 respectfully. For example for the array `[0,0,0,1,1,2,2]`, the frontier for 0 would be `3`, the frontier for 1 would be `5` and the frontier for 2 would be `7`. Note that it is the index for **one index after** the last element and not the index of the element itself]. 

As we loop through the array:
- If the element is a **0**. We swap the element with the frontier for 1 *and then* swap the frontier for 1 with the frontier for *0*. We increment **all 3 frontiers**.
- If the element is a **1**. We swap the element with the frontier for 1. We increment frontier **1 and 2**.
- If the element is a **2**. We swap the element with the frontier for 2. We only increment frontier **2**.n

# Code
---
```cpp
    void sortColors(vector<int>& nums) {
        int front = 0;
        int front1 = 0;
        int front2 = 0;
        for(int i = 0; i < nums.size(); i++){
            switch(nums[i]){
                case 0:
                    swap(nums[i], nums[front1]);
                    swap(nums[front1], nums[front]);
                    front++;
                    front1++;
                    front2++;
                    break;
                case 1:
                    swap(nums[i], nums[front1]);
                    front1++;
                    front2++;
                    break;
                case 2:
                    swap(nums[i], nums[front2]);
                    front2++;
                    break;
            }
        }
    }
```