# two screens
---
>[!summary] Codeforces educational round 170 A. Relatively simple

# Explanation
---
[[ad hoc]]
# Code
---

```cpp

void solve(int tc)
{
	string a,b; cin >> a >> b;
	int out = 0;
	
	int ptr = 0;
	while(ptr < min(a.size(), b.size())){
		if(a[ptr] != b[ptr]){
			break;
		}
		ptr++;
	}


	if(ptr) out += ptr+1;
	out += a.size()-ptr;
	out += b.size()-ptr;

	cout << out << endl;
}
```