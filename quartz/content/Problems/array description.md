# array description
---
>[!summary] A hard CSES DP problem

# Explanation
---
This is an interesting twist on [[the knapsack problem#bounded|bounded knapsack problem]]. We can use a 2d [[dynamic programming|DP]] array to solve this problem where `dp[i][x]` refers to the solution to the problem where the array goes up to and including index `i` and where the value at that index is set to `x`.

### Base cases
As a **base** case, lets consider the first row, index 0. In this scenario, we have two possibilities, either the first element of the array is 0, or a fixed value. 

If the first element is zero, we can pick any number in the beginning, meaning that all `x`'s  are applicable here. There is only 1 possibility for a single element for a valid array description, which is to set it to whatever `x` is. Therefore we set the entire top to the value 1. 

If the first element is fixed, only the value of the first element is applicable and everything else is impossible. Therefore, we set everything to 0 except for when `x` is equal to `arr[i]`.


### DP stage
Now for cases where `i > 0`. Again, we have two possibilities, either `arr[i]` is 0 or a fixed value. 

If `arr[i] = 0`,  any value of `x` is permissible, but for `arr[i]` to be equal to `x`, the previous index must be adjacent or the same. Therefore we can say that:

$$
arr[i][x] = \sum\begin{cases} arr[i-1][x-1], \\
                              arr[i-1][x],   \\ 
                              arr[i-1][x+1]
\end{cases}
$$
> [!warning]
> remember, when summing these values, mod by $10^{9}+7$!

Notice `i-1`: This means that we are going back a row, to the value of the last element in the array that goes up to index `i-1`. From that, we check the possibilites when the value is less than the current `x` (`[i-1][x-1]`) , when it's the same (`[i-1][x]`) or when it's one greater (`[i-1][x+1]`). Of course if `x` is 1 or the max value, you can't really refer outside of bounds. 

For the possibility where `arr[i]` is not 0 and is fixed. In this case, similar to the base case, all values of `x` which is not equal to `arr[i]` are left to  `0` , since those cases don't match the array description. For the value where `x` *is* equal, we use the same DP formula as above. 

# Code
---
```cpp

void solve()
{
	int n, m; cin >> n >> m;
	vector<ll> arr(n,0);
	for(int i = 0; i < n; i++){
		cin >> arr[i];
	}

	vector<vector<ll>> dp(n, vector<ll>(m,0));

	// base case i = 0
	if(arr[0] == 0){
		for(auto &i : dp[0])
			i = 1; 
	}
	else
	{
		dp[0][arr[0]-1] = 1;
	}
	for(int i = 1; i < n; i++)
	{
		//cout << arr[i] << ": ";
		if(arr[i] == 0){
			dp[i][0] = dp[i-1][0]+dp[i-1][1]; dp[i][0] %= MOD;
			for(int j = 1; j < m-1; j++)
			{
				dp[i][j] = dp[i-1][j-1] + dp[i-1][j] + dp[i-1][j+1]; dp[i][j] %= MOD;
			}
			dp[i][m-1] = dp[i-1][m-1] + dp[i-1][m-2]; dp[i][m-1] %= MOD;
		}
		else
		{
			if(arr[i] == 1)
				dp[i][0] = dp[i-1][0]+dp[i-1][1]; 
			else if(arr[i] == m)
				dp[i][m-1] = dp[i-1][m-1] + dp[i-1][m-2];
			else
				dp[i][arr[i]-1] = dp[i-1][arr[i]-2] + dp[i-1][arr[i]-1] + dp[i-1][arr[i]];
			dp[i][arr[i]-1] %= MOD;
		}
	}
	int out = 0;
	if(arr.back() == 0)
	{
		for(auto i : dp.back())
		{
			out += i ;
			out %= MOD;
		}
	}
	else
	{
		out = dp.back()[arr.back()-1];
	}
	cout << out << endl;
}


```