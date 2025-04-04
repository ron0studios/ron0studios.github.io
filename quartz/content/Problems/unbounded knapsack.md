# hackerrank knapsack
---
>[!summary] 
>A classic [[dynamic programming]] problem

# Explanation
---
Unlike regular [[the knapsack problem|knapsack]], this asks for the highest sum achievable by *n* coins that doesn't exceed k. use a dp [[matrix|grid]]

# Code
---
```cpp
int unboundedKnapsack(int k, vector<int> arr) {
    vector<vector<int>> dp(arr.size()+1,vector<int>(k+1,0));

    for(int i = 1; i <= arr.size(); i++)
    {
        for(int j = 1; j <= k; j++)
        {
            int without = dp[i-1][j];
            int with = -1; 
            if(j >= arr[i-1])
            {
                with = dp[i][j-arr[i-1]] + arr[i-1];
            }
            dp[i][j] = max(with,without);
        }
    }
    return dp.back().back();
}
```