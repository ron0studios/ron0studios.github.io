# hit the lottery
---
>[!summary] easy codeforces problem


# Explanation
---
literally just pick the biggest coin [[Greedy|greedily]]

# Code
---
```cpp
    #include <bits/stdc++.h>
     
    using namespace std;
     
    int main()
    {
        int n; cin >> n;
        int x = 0;
        vector<int> nums = {100,20,10,5,1};
        while(n)
        {
            for(auto i : nums)
            {
                if( i <= n)
                {
                    x++;
                    n -= i;
                    break;
                }
            }
        }
        cout << x;
     
        return 0;
    }
```