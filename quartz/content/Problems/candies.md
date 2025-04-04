# candies
---
>[!summary] Annoying hackerrank problem


# Explanation
---
This is a [[Greedy]] problem. 

Essentially you break up the problem into 4 pieces:
- valleys
- rises
- falls
- peaks



# Code
---
```cpp
long candies(int n, vector<int> arr) {
    vector<int> candies(n+1,0); // extra 1 for padding
    // index 0
    if(arr[0] <= arr[1]) candies[0] = 1;

    for(int i = 1; i < n; i++)
    {
        if(arr[i] <= arr[i+1] and arr[i] <= arr[i-1])
        {
            candies[i] = 1;
        }
    }

    for(int i = 1; i < n; i++)
    {
        if(arr[i] <= arr[i+1] and arr[i-1] < arr[i])
        {
            candies[i] = candies[i-1] + 1; 
        }
    }

    for(int i = n-1; i >= 1; i--)
    {
        if(arr[i-1] >= arr[i] and arr[i+1] < arr[i])
        {
            candies[i] = candies[i+1] + 1;
        }
    }
    
        if(arr[0] >  arr[1]) candies[0] = candies[1]+1;
    for(int i = 1; i < n; i++)
    {
        if(arr[i] > arr[i+1] and arr[i] > arr[i-1])
        {
            candies[i] = max(candies[i-1],candies[i+1])+1;
        }
    }
    long out = 0;
    for(auto i : candies) out += i;
    return out;
}
```