---
aliases: 
date: 2025-03-21
time taken (mins): "20"
---


# pairs of songs with total durations divisible by 60
---
>[!summary] LC1010. Nice [[two pointers method]] problem. took around 15-20 mins .


# Explanation
---

This problem is a variant of [[sum of two values]]. You need to MOD all values in the original array by 60, since it is only the remainders of 60 that we need to consider when checking if two numbers sum to make a **multiple** of 60.
We then aggregate all the values into an array of size 60, where `arr[i]` is the count of numbers in the modded array that is equal to i.

For each pair around 30, e.g. (1,59) (25,35) or (29,31), we add `count[i]*count[j]` to the answer. 

The two special cases are when `i=30, i=0`, in which we do $\frac{n(n-1)}{2}$  on `count[i]`

# Code
---
[This gets 100% runtime on leetcode 🔥](https://leetcode.com/problems/pairs-of-songs-with-total-durations-divisible-by-60/submissions/1581638436)
```cpp
    int numPairsDivisibleBy60(vector<int>& time) {
        vector<long long> counts(60,0);
        int c = 0;
        for(int i = 0; i < time.size(); i++){
            counts[time[i]%60]++;
        }

        c += (counts[0]*(counts[0]-1))/2;
        c += (counts[30]*(counts[30]-1))/2;

        for(int i = 1; i < 30; i++){
            c += counts[i]*counts[60-i];
        }
        
        return c;
    }
```