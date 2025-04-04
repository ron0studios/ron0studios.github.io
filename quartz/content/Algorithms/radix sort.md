# radix sort
---
>[!summary] A linear [[sorting]] algorithm that incorporates [[counting sort]] to sort items by **digit** (right to left).


# Explanation
---
The algorithm exploits the fact that [[counting sort]] is a **stable** algorithm^[meaning that the internal order of elements is preserved (i.e. {4, 2a, 1, 2b, 5} is sorted as {1, 2a, 2b, 4, 5} ).] to sort a number digit by digit in linear time. We start by sorting a list by its **least** significant digit, and then by the **second least** significant digit and so on until we sort by the **most** significant digit. 
The [[counting sort]] algorithm is perfect for ordering each digit, because a digit can only be between 0-9, which is a comparably small range to the number of elements we are sorting.

The time complexity of this algorithm is $\mathcal{O}(d(n+k))$, because the time complexity of [[counting sort]] is $\mathcal{O(n+k)}$, for a range of values , $k$, and we are performing it for every digit, $d$. 

# code
```cpp
ll mx = (ll)(log(maxel) / log(b));
for(int i = 0; i <= mx; i++){
	vector<ll> buckets(b,0);
	vector<ll> idx(inp.size());
	for(int j = 0; j < inp.size(); j++){
		idx[j] = (inp[j] >> (15*i) )% b;// / (ll)powl(b,i)) % b;
		buckets[idx[j]]++;
	}
	vector<ll> prefix(b,0);
	prefix[0] = 0;
	for(int j = 1; j < b; j++){
		prefix[j] = prefix[j-1]+buckets[j-1];
	}


	vector<ll> out = inp;
	for(int j = 0; j < inp.size(); j++){
		out[prefix[idx[j]]++] = inp[j];
	}
	inp = out;
}

```