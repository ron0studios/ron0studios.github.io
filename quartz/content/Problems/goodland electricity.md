# goodland electricity
---
>[!summary] 
>A pretty hard hackerrank problem


# Explanation
---
This is a [[Greedy]] problem, pretty similar to [[candies]] and  [[greedy florist]].

The way to construct the solution is to **pick the pylon with the earliest starting reach and the largest area of new, unpowered, space**.

For example, a pylon could be placed anywhere on a 10-element long stretch, and had a diameter reach of 5 (inclusive), then any pylon placed in indexes `[0,1,2]` would all have the same starting reach of $0$. Since index `2` has the largest spanning area of unpowered space it covers (of 5), it will be the first to be placed.

Here are the optimizations used to improve efficiency on larger test cases:
- when looping through the entire list, start on the index where the last pylon was placed. 
- break out early if we've found the largest area in the earliest position already

# Code
---
```cpp
//greedy, earliest start most area
int pylons(int k, vector<int> arr)
{
	vector<int> lit(arr.size(),0);
	int ops = 0;
	int last = 0;
	while(true)
	{
		int idx = -1; // start
		int area = 0;
		int start = INT_MAX;
		
		for(int i = last; i < arr.size(); i++)
		{
			int tmp = 0;
			int tmp_s = -1;
			if(arr[i] == 1)
			{
				for(int j = max(i-k+1,0); j < min((int)arr.size(),i+k); j++)
				{
					tmp += !lit[j];
					if(lit[j] == 0 and tmp_s == -1) tmp_s = j;
				}
			}
			if(tmp_s > start) break;
			if(tmp > area and tmp_s <= start)
			{
				area = tmp;
				idx = i;
				start = tmp_s;
			}
		}
		if(idx == -1) break;
		
		for(int j = max(idx-k+1,0); j < min((int)arr.size(),idx+k); j++)
		{
			lit[j] = 1;
		}
		last = idx;
		
		ops ++;
	}
	
	for(auto i : lit)
	{
		if(i == 0)
		{
			return -1;
		}
	}
	return ops;
}
```