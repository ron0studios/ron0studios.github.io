# Dice combinations
---
> **Given N and infinite dice, how many ways can you construct N?**


# Explanation
---
We are able to solve this using [[dynamic programming]]. Take a table of values and sum up dp(n-1), dp(n-2) ... dp(n-6), to get your answer. Refer to the top answer [here](https://www.quora.com/How-do-you-find-the-number-of-ways-the-sum-of-k-dice-rolls-equals-S-for-an-n-sided-fair-die) for a [[combinatorics]] method on solving this, I do not understand it but may look into it further at some point

# Code
---
```c++
void solve(int tc)
{
	int n; cin >> n;
	vector<int> demo(n+1,0);
	demo[0] = 1;
	for(int i = 0; i <= n; i++)
	{
		for(int j = 1; j <= 6; j++){
			if(i-j >= 0){
				demo[i] += demo[i-j];
			}
		}
	}
	cout << demo[n] << "\n";
}
```