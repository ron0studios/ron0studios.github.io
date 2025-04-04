# max counters
---
>[!summary] A codility problem. Relatively interesting [[range query]] problem^[not exactly using range queries, but the same underlying principle].Took around 15 minutes. 


# Explanation
---
> [!warning] NOTE: this is **not** a [[range query]] problem, its just a similar technique!

This problem requires you to "*defer*" all the updates that modify the whole array. In this case that update is `max counter`, which sets **all** elements in the array to the maximum value of the whole array. 

Instead of running through the whole array we can instead update a value called `baseline` which maintains a store of the **minimum** value the array could be, which is the value of the *last* `max counter` operation done on the array. 

For example if we run `max counter` and the maximum value of the array was 3, then the baseline from that point onwards (until the next `max counter` operation if it exists) will be 3, since all values were updated to 3.

If we update array elements **lazily**, i.e. only when they come around, then we can run all the queries in $\pmb{\mathcal{O}(N)}$  time. We can, at the end, sweep through the array and check for any elements that haven't been interacted with and set then to `baseline`
# Code
---
```cpp
vector<int> solution(int N, vector<int> &A) {
    vector<int> arr(N, 0);
    int mx = 0;
    int baseline = 0;
    for(int i = 0; i < A.size(); i++){
        if(A[i] > N){
            baseline = mx;
        } else {
            arr[A[i]-1] = max(baseline, arr[A[i]-1]);
            arr[A[i]-1]++;
            mx = max(mx, arr[A[i]-1]);
        }
    }

    for(int i = 0; i < N; i++){
        arr[i] = max(baseline, arr[i]);
    }

    return arr;
}
```