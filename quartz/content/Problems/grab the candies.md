# grab the candies
---
>[!summary] easy codeforces problem


# Explanation
---
This is some pretty simple [[Greedy]] stuff, just [[sorting|sort]] the array. 

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> candies(n,0);
	vector<int> odd, even;
	int oc, ec; oc = ec = 0; // odd count, even count
	for(int i = 0; i < n; i++){
		cin >> candies[i];
		if(candies[i] % 2){
			odd.pb(candies[i]);
			oc += candies[i];
		}
		else {
			even.pb(candies[i]);
			ec += candies[i];
		}
	}
	if(oc >= ec) {cout << "NO\n"; return;}
	cout << "YES\n";
}
```