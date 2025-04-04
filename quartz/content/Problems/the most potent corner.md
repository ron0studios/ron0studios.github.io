# the most potent corner
---
>[!summary] UVA 10264. A fun [[bitwise operations]] problem. Took around 45 mins


# Explanation
---
This problem requires you to use [[bitwise operations]] to find two binary strings that differ by **only** 1 bit. The `^` XOR operator flips a single bit in a number, which means that it chanes a number by only 1 bit. Therefore if we perform an XOR on every bit in a number, we can get all the *adjacent* corners to a coordinate in a cube.
# Code
---
```cpp
void solve(int n)
{
	int len = pow(2,n);
	vector<int> weights(len);
	vector<int> sums(len);
	for(int i = 0; i < len; i++){
		cin >> weights[i];
	}

	int mx = -1;
	for(int i = 0; i < len; i++){
		for(int j = 0; j < n; j++){
			sums[i] += weights[i^(1<<j)];
		}
	}
	for(int i = 0; i < len; i++){
		for(int j = 0; j < n; j++){
			mx = max(mx, sums[i]+sums[i^(1<<j)]);
		}
	}
	cout << mx << endl;
}
```