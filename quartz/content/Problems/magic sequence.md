# magic sequence
---
>[!summary] kattis-magicsequence. A hard **optimisation** problem. Took me 3 hours, possibly more because of debugging. 


# Explanation
---
Using a simple `std::sort` will not suffice for the time restrictions of this problem, as we need to complete in under 2 seconds. Since the range of numbers can be at most $10^{9}$, we can actually use [[radix sort]] with a *custom* base. 
The choice of base matters significantly since if it is too small then we will be ordering too many digits but if it is too big then we will exhaust memory or have too big a range of values to sort. 
The optimal choice will be the base that minimises the number of *passes* we have to sort through. $2^{15}$ or $32768$ is a good number since we only need a maximum of **2** passes to sort the array ($(2^{15})^{2}=2^{30}\approx 10^{9}$). Since it is a power of 2 we can also use [[bitwise operations]] instead of regular multiplication and division for some operations which also improves performance.
A base-32768 radix sort will require some small modifications from the original algorithm, but it is mostly the same. 

> [!warning] `long long` operations are **slow**
> I had a pain debugging this problem since I was running into TLE issues within a fraction of a second of the time limit. The issue was that all my operations were done with `long long` numbers, when using just `int` was sufficient.

# Code
---
```cpp
int n,a,b,c,x,y;
int maxel = -1;

vector<int> radix(vector<int> inp){
	vector<int> buckets(32768, 0);
	vector<int> idx(n,0);
	vector<int> prefix(32768, 0);
	vector<int> out = inp;

	// sort first base-32768 digit column
	for(int i = 0; i < n; i++) {
		idx[i] = inp[i] & 32767;
		buckets[idx[i]]++;
	}

	for(int i = 1; i < 32768; i++){
		prefix[i] = prefix[i-1]+buckets[i-1];
	}

	for(int i = 0; i < n; i++){
		out[prefix[idx[i]]++] = inp[i];
	}

	if(maxel <= 32768){
		return out;
	}

	inp = out;
	fill(buckets.begin(), buckets.end(), 0);
	fill(prefix.begin(), prefix.end(), 0);
	fill(idx.begin(), idx.end(), 0);

	// sort second base-32768 digit column
	for(int i = 0; i < n; i++) {
		idx[i] = (inp[i] >> 15) & 32767;
		buckets[idx[i]]++;
	}

	for(int i = 1; i < 32768; i++){
		prefix[i] = prefix[i-1]+buckets[i-1];
	}

	for(int i = 0; i < n; i++){
		out[prefix[idx[i]]++] = inp[i];
	}

	return out;
}





void solve(int tc)
{
	cin >> n >> a >> b >> c >> x >> y;
	maxel = -1;
	vector<int> R(n,a);
	for(int i = 1; i < n; i++){
		R[i] = (1LL*R[i-1]*b+a)%c;
		maxel = max(maxel, R[i]);
	}
	R = radix(R);

	int v = 0;
	for(int i = 0; i < n; i++){
		v = (1LL*v*x + R[i]) % y;
	}

	cout << v << endl;

}
```