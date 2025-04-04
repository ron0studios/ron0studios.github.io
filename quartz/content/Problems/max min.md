# max min
---
>[!summary] not a type (lol), its a hackerrank problem!


# Explanation
---
This is a pretty simple [[Greedy]] problem. 

What you have to do is [[sorting|sort]] the array and go through every consecutive set of $k$ elements and record the difference between the last and first element of the subset. 

# Code
---
```cpp
int maxMin(int k, vector<int> arr) {
    sort(arr.begin(),arr.end());
    int mindiff = INT_MAX;
    for(int i = k-1; i < arr.size(); i++)
    {
        vector<int> x = vector<int>(arr.begin()+(i-k+1),arr.begin()+i+1);
        mindiff = min(mindiff, x.back()-x.front());
    }
    return mindiff;
}
```
