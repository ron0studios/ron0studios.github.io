# merge overlapping intervals
---
>[!summary] Leetcode 56. An interesting [[sorting]] problem. Took 30 mins to find a valid [[ad hoc]] solution, and 15 more to recognise the sorting solution (given the hint it was a sorting problem).


# Explanation
---
This problem can be *easily* solved by just maintaining a boolean array and manually filling the array with all the input intervals, and then just scanning through to see how many intervals of consecutive 1's there are^[forgot to add this in but also note to add a separate number e.g. 2 instead of 1 or when]. However, this is not only memory inefficient, but very slow.

A better, and neater, solution would be to **sort** the array of intervals in a somewhat lexicographic order, *i.e.* $[1,2] \lt [1,3]$.  Once we've sorted the array we can now guarantee the array is ordered so that all the starting indices of the intervals are grouped together, *i.e.* all the intervals starting with `1` are grouped together, and the interval endings in this group are in sorted order. Therefore, if we take the maximum in this group, and find the closest interval start to that maximum, we can find the maximum interval.

# Code
---
### My original [[ad hoc]] solution
[here](https://leetcode.com/problems/merge-intervals/submissions/1394270066). Average performance and lacklustre memory consumption. But it works 🔥
```cpp
    vector<vector<int>> merge(vector<vector<int>>& intervals) {
        vector<int> tot;
        for(int i = 0; i < intervals.size(); i++){
            while(tot.size() < intervals[i][1]+1)
                tot.push_back(0);
            for(int j = intervals[i][0]; j < intervals[i][1]; j++){
                tot[j] = 1;
            }
            if(tot[intervals[i][1]] != 1)
            tot[intervals[i][1]] = 2;
        }

        vector<vector<int>> out;
        bool flag = false;
        for(int i = 0; i < tot.size(); i++){
            if(!flag && tot[i]){
                out.push_back({i,i});
                if(tot[i]==1) flag = true;
            }
            if(flag){
                if(tot[i]){
                    out.back()[1] = i;
                    if(tot[i]==2){
                        flag=false;
                    }
                }
                else flag = false;
            }
        }
        return out;
    }
```

### Better sorting solution
[here](https://leetcode.com/problems/merge-intervals/submissions/1394376132). Easier on the eyes, and much more faster+efficient.
```cpp
    vector<vector<int>> merge(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end());
        vector<vector<int>> out = {intervals[0]};
        for(int i = 1; i < intervals.size(); i++){
            if(intervals[i][0] == out.back()[0]){
                out.back()[1] = max(out.back()[1], intervals[i][1]);
            }
            else{
                if(intervals[i][0] <= out.back()[1]){
                    out.back()[1] = max(out.back()[1], intervals[i][1]);
                }
                else{
                    out.push_back(intervals[i]);
                }
            }
        }
        
        return out;
        
    }
```