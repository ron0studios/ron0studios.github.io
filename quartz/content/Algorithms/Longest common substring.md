# Longest common substring
---
>[!summary] A pretty common [[dynamic programming]] scenario

In this scenario, unlike its non-contiguous counterparts, you shouldnt pull forward any values from other cells if the two elements arent equal!


>[!warning]
>avoid confusing this with the [[Longest common subsequence]], they are completely different. One is **contiguous**^[the substring one] and the other is not!


# Example code
---
```cpp
int LC_substring(string a, string b)
{
	vector<vector<int>> dp((int)a.length()+1, vector<int>((int)b.length()+1,0));
	int maxlen = -1;

	for(int i = 1; i <= (int)a.length(); i++)
	{
		for(int j = 1; j <= (int)b.length(); j++)
		{
			if(a[i-1] == b[j-1]){
				dp[i][j] = dp[i-1][j-1]+1;
				maxlen = max(maxlen, dp[i][j]);
			}
		}
	}

	return maxlen;
}
```