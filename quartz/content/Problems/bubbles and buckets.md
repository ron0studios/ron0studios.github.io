# bubbles and buckets
---
>[!summary] UVA 11495. An algorithmic [[sorting]] problem. took around 30 mins


# Explanation
---
This is a direct application of the [[Inversion counting|inversion index]] with basic [[game theory]]. Essentially if the number of swaps needed to sort the array is even, then carlos wins, otherwise marcelo wins.
This problem is similar to [[DNA sorting]].
# Code
---
```cpp
int inversions = 0;

vector<int> invcnt(vector<int> inp){
	if(inp.size() < 2) return inp;

	vector<int> L = invcnt(vector<int>(inp.begin(), inp.begin()+inp.size()/2));
	vector<int> R = invcnt(vector<int>(inp.begin()+inp.size()/2, inp.end()));
	vector<int> O;
	int l = 0, r = 0;
	int tmpinvs = 0;
	while(l < L.size() and r < R.size()){
		if(L[l] <= R[r]){
			O.pb(L[l]);
			l++;
		} else {
			O.pb(R[r]);
			r++;
			inversions += L.size()-l;
			tmpinvs += L.size()-l;
		}
	}

	while(l < L.size()) {
		O.pb(L[l++]);
	}

	while (r < R.size()){
		O.pb(R[r++]);
	}

	return O;
}

```