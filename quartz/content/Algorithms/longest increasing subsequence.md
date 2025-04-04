# longest increasing subsequence
---
> A very popular (and useful) [[dynamic programming]] algorithm


## Problem
---
The **longest increasing subsequence** algorithm finds the longest set of elements in a list such that each element is greater than the last, *but not necessarily adjacent*.

## O(N<sup>2</sup>) solution
---
This solution involves building a dp array from the bottom up. 

Consider an array of length *N*, where each point in the array refers to the longest increasing subsequence **that ends** at that index^[A common misconception is that this point refers to the longest increasing subsequence of a substring up to that index]. 

We begin a loop through the array, and add a nested loop, that loops through all indexes in the DP array before, and excluding the current index. We do this to find the maximum element so far traversed and add 1 **only if** the number that the subsequence at that index ends *is less than* the number of the subsequence of this current index. 

After we're done, the LIS should be the biggest element in the array

### Code
```cpp
int lis(vector<int> const& a) {
    int n = a.size();
    vector<int> d(n, 1);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (a[j] < a[i])
                d[i] = max(d[i], d[j] + 1);
        }
    }

    int ans = d[0];
    for (int i = 1; i < n; i++) {
        ans = max(ans, d[i]);
    }
    return ans;
}
```

## O(NlogN) solution
This solution involves building a dp array and replacing indices along the way.
idk how this works, but I have a vague idea of it :-/

The solution is $O(NlogN)$ because the `lower_bound` function runs a binary search to find the next highest number to $x$ in an array, which runs in $O(logN)$ time. 
Each element in the DP array refers to the longest common subsequence of some substring [0...i] which ends in the smallest number^[here im using a string but its the same thing]

At each point in the original array, we check if `arr[i]` is greater than the last element of the DP array, which in the beginning is just the first element of the array. If it is, then we simply add it to the end of the DP array. 

If it isn't, we find the next number that's bigger than `arr[i]` in the DP array and replace that element with it. the `lower_bound` function does that for us, using binary search. If all your elements are unique, you could also use `upper_bound` if you want, but its safer to use the former. 

There are 2 key insights to draw from this method:
- the DP array is always sorted.
- each element of the original array only replaces 1 element in the DP array.

hence, we've generated the longest increasing subsequence in the array with the smallest elements possible at every point.

```cpp

int lis(string inp)
{
	vector<char> out; 
	out.pb(inp[0]);
	for(int i = 1; i < inp.length(); i++)
	{
		if(out.back() < inp[i]) 
		{
			out.pb(inp[i]);
		}
		else{
			int next_greatest = lower_bound(out.begin(),out.end(),inp[i])-out.begin();
			out[next_greatest] = inp[i];
		}
	}
	return out.size();
}

```
