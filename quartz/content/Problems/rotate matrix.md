# rotate matrix
---
>[!summary] Leetcode 48. A simple leetcode problem that i over-complicated by being stupid. Took around 1 hour.


# Explanation
---
The solution to this problem is to flip the [[matrix]] by its diagonal like in [[have fun with matrices]] and then flip it horizontally.

My awful idea was to rotate each "group" of 4 squares in basically a spiral. This was quite memory efficient, but awfully slow.

# Code
---
### my god awful solution 💀
[here](https://leetcode.com/problems/rotate-image/submissions/1392549380).
```cpp
    void rotate(vector<vector<int>>& matrix) {
        int n = matrix.size();
        for(int i = 0; i < n/2; i++){
            for(int j = 0; j < n-1-i*2; j++){
                swap(matrix[i][i+j], matrix[n-1-i][n-1-i-j]);
                swap(matrix[i][i+j], matrix[n-1-i-j][i]);
                swap(matrix[i+j][n-1-i], matrix[n-1-i][n-1-i-j]);
            }
        }
    }
```

### the actual solution
[here](https://leetcode.com/problems/rotate-image/submissions/1392559140)
```cpp
    void rotate(vector<vector<int>>& matrix) {
        int n = matrix.size();
        for(int i = 0; i < n; i++) {
            for(int j = i+1; j < n; j++) {
                swap(matrix[i][j], matrix[j][i]);
            }
        }
        for(int i = 0; i < n; i++){
            reverse(matrix[i].begin(), matrix[i].end());
        }
    }
```