# largest permutation
---
>[!summary] 
>Hackerrank problem that I spent hours on because of this one god awful bug that I couldn't figure out 😢


# Explanation
---
This is a [[Greedy]] problem. Essentially, you can construct a solution like so:
- Take the largest element in the array, via [[sorting|sort]].
- Swap that element with the earliest possible point in the array

The earliest possible point refers 

# Code
---
```cpp
vector<int> largestPermutation(int k, vector<int> arr) {
    vector<pair<int,int>> arrmem;
    for(int i = 0; i < arr.size(); i++)
    {
        arrmem.pb(mp(arr[i],i));
    }
    sort(arrmem.begin(),arrmem.end());
    reverse(arrmem.begin(),arrmem.end());

    unordered_map<int,int> mem;
    for(int i = 0; i < arrmem.size(); i++)
    {
        mem[arrmem[i].first] = i;
    }

    int up = 0;
    while(k--)
    {
        int maxidx = arrmem[up].second;

        if(up==arr.size()) break;
        if(maxidx == arr.size() - arr[maxidx])
        {
            up++;
            k++;
            continue;
        }
        arrmem[up].second = up;
        arrmem[mem[arr[up]]].second = maxidx;

        iter_swap(arr.begin()+up,arr.begin()+maxidx);
        up++;
    }

        
    return arr;
}
```