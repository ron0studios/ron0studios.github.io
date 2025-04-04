# illuminate buildings
---
>[!summary] abc385 C. A fun [[Brute force]] problem. Took around 20 mins


# Explanation
---
This problem appears as if it needs some algorithm to solve it. However, due to the very loose restrictions in the input, we are able to simply loop through every possible interval and find the longest *streak* of items with the same number. 
# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<int> h(n);
	for(int i = 0; i < n; i++){
		cin >> h[i];
	}

	int out = -1;
	for(int i = 1; i < n; i++){
		for(int j = 0; j < i; j++){
			int prev = h[j];
			int mx = 0;
			int streak = 0;
			for(int k = j; k < n; k += i){
				if(h[k] == prev){
					streak++;
				} else {
					mx = max(mx, streak);
					streak = 1;
				}
				prev = h[k];
			}
			mx = max(mx, streak);
			out = max(out, mx);
			//cout << i << " " << j << " " <<  cnt << endl;
		}
	}

	if(out<0) cout << 1 << endl;
	else cout << out << endl;

}
```