# Algorithm of Phil
---
>[!summary]  UVA 12720. A relatively interesting problem. Took around 45 mins.


# Explanation
---
This problem requires a bit of [[bitwise operations]] (no pun intended) and [[two pointers method]] to get right. It is simply a simulation of the actual algorithm but without any string removal operations since they are too slow. Note that we need to perform a **modulo** operation for **every** new addition to the output since we multiply by 2 in every step of Phil's algorithm (bitwise left shift). 
# Code
---
```cpp
void solve(int tc)
{
	string a; cin >> a;
	unsigned ll s = 0;
	int rptr = a.size()/2;
	int lptr = a.size()/2 - !(a.size()%2);
	bool odd = a.size()%2;
	int len = a.size();
	if(odd){
		s |= a[rptr]-'0';
		rptr++;
		lptr--;
		len--;
		odd = false;
	}
	while(rptr < a.size() and lptr+1){
		s <<= 1;
		if(odd){
			if(len/2 == lptr){
				s |= a[lptr]-'0';
				lptr--;
			} else{
				s |= a[rptr]-'0';
				rptr++;
			}
		} else {
			if(a[lptr]>a[rptr]){
				s |= a[lptr]-'0';
				lptr--;
			} else{
				s |= a[rptr]-'0';
				rptr++;
			}
		}
		odd = !odd;
		s %= MOD;
		len--;
	}

	while(rptr < a.size()){
		s <<= 1;
		s |= a[rptr]-'0';
		rptr++;
		s %= MOD;
	}
	while(lptr+1){
		s <<= 1;
		s |= a[lptr]-'0';
		lptr--;
		s %= MOD;
	}

	cout << "Case #" << tc << ": " << s << endl;
}
```