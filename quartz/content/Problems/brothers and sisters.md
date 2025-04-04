# brothers and sisters
---
>[!summary] UVA 12571. A relatively simple [[bitwise operations]] problem. Took around 15 minutes.


# Explanation
---
Just need to use [[dynamic programming|DP]] to precalculate the maximum `AND` value for each query, since there are only 230 different possibilities, compared to an array size of 100000.
# Code
---
```cpp
void solve(int tc)
{
	int n,queries; cin >> n >> queries;
	vector<int> arr(n);
	for(int i = 0; i < n; i++)
		cin >> arr[i];
	vector<int> dp(231,-1);
	for(int i = 0; i < queries; i++){
		int q; cin >> q;
		if(dp[q]==-1){
			for(int j = 0; j < n; j++){
				dp[q] = max(dp[q], arr[j]&q);
			}
		}
		cout << dp[q] << endl;
	}
}

```