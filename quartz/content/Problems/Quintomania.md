# Quintomania
---
>[!summary] Codeforces 2036A. Easy problem. took 2 minutes 😮


# Explanation
---
[[ad hoc]]. simply do a linear scan of the input and check for 7 semitone or 5 semitone differences.
# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> mel(n);
	for(int i =0; i < n; i++)
		cin >> mel[i];

	for(int i = 1; i < n; i++){
		if(abs(mel[i]-mel[i-1]) == 5 or abs(mel[i]-mel[i-1]) == 7) {
		}
		else{
			cout << "NO" << endl;
			return;
		}
	}
	
	cout << "YES" << endl;
}
```