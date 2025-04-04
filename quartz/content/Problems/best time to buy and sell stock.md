# best time to buy and sell stock
---
>[!summary] Leetcode 121. Pretty simple problem. Took 10 mins, but a further X minutes to optimise.


# Explanation
---
This problem is a variation of [[Kadane's algorithm]], which is typically used to solve the *maximum subarray* problem. 

The [[dynamic programming|DP]] in this problem is basically the same, maintaining a state where `dp[i]` is the greatest profit we can make where we **sell at time *i***.  The transition essentially is $$dp[i] = max(0, dp[i-1]+\Delta price[i])$$ where $\Delta price[i]$ is the difference in price between time `i` and time `i-1`. Looping through the array and maintaining a **maximum** value variable will solve the problem for us. 

> [!question]
> For some reason the `max` function just runs **super** inefficiently on leetcode? I recreated the code with `if` statements and it ran 20ms faster (compared to ~80). Will investigate this at some point^[written this note on 15/09/24]
# Code
---
## Kadane's algorithm version
Much cleaner solution but for some reason does terribly on [leetcode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/submissions/1390216709)
```cpp
    int maxProfit(vector<int>& prices) {
        if(prices.size() < 2) return 0;
        int prev = max(0, prices[1]-prices[0]);
        int mx = prev;
        for(int i = 2; i < prices.size(); i++){
            prev = max(0, prev+prices[i]-prices[i-1]);
            mx = max(mx, prev);
        }
        return mx;
    }
```
## Optimised version
Runs much better on [leetcode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/submissions/1390230111) but looks **UGLY**
```cpp
    int maxProfit(vector<int>& prices) {
        int prev = 0;
        int mx = 0;
        for(int i = 1; i < prices.size(); i++){
            if(prev+prices[i] > prices[i-1]){
                prev += prices[i]-prices[i-1];
                if(prev > mx) mx = prev;
            } else {
                prev = 0;
            }
        }
        return mx;
    }
```