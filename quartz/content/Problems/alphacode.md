# alphacode
---
>[!summary] A pretty hard SPOJ problem


# Explanation
---
This is a [[dynamic programming]] problem that focuses on techniques similar to fibonacci or [[Coin Change]], in that it requires a single contiguous dp array representing, where `dp[x]` equals the input up to index `x`. 

All letters of the alphabet, according to alphacode, fall within the range of 1 to 26 (inclusive). This means that there are either 1 or 2 digits for each letter. All possible alphacodes, therefore, result from deviations in choosing whether a part of the number should be represented by 2 digits or 1 digit^[for example `11` can be reprented as `AA` or `K`].


### DP >=  1

When we *do have* the possibility of choosing between 1 or 2 digits, we know that the pair of numbers in the input is $\leq 26$. For example, in the code `926`, we have the option in the pair `26`, where we can treat them individually or together, but we *do not* have that same option in the pair `92`. 

From this we can gather that:
- *if* we can pick between two options, then the answer at that particular index of the array is equal to `dp[i-1] + dp[i-2]`.
-  `dp[i-1]` refers to the situation where we consider `dp[i]` individually, therefore using the result of the string up to `dp[i-1]`.
-  `dp[i-2]` refers to the situation where we consider the pair `dp[i-1],dp[i]` as a two digit code for a letter, in which case we refer to the result before those two digits, which is `dp[i-2]`.

### DP < 1
There are some other considerations we have to make before we're done, primarily being the situation with zeros. 

Having a zero in the code is tricky since `0` on its own doesn't correspond to any letter^[remember that letters are only between 1 and 26]. 
In this case:
- if `dp[i] = 0`, then the only possibility is having the twin `dp[i-1], dp[i]` (i.e `10` or `20`), which means you take the result of `dp[i-2]`. 
- If `dp[i-1]` is zero and `dp[i]` isn't, then the only possibility is considering `dp[i]` individually, meaning you should take the result of `dp[i-1]`. 
- If both `dp[i]` and `dp[i-1]` are zero, we can break out and return zero because this code is impossible and has no corresponding words. 

### Final DP
To put it mathemtically^[I've used $\cap$ as string concatenation here]:
$$
dp[i] = \begin{cases} 
0  & \text{if both }dp[i]\text{ and }dp[i-1]\text{ are 0} \\
dp[i-2]  & \text{if }dp[i]\text{ is 0 but }dp[i-1]\text{ isnt}\\
dp[i-1]  & \textbf{either } dp[i-1]\text{ is 0 but }dp[i]\text{ isnt} \\
 & \textbf{or }dp[i-1]\cap dp[i]>26 \\
dp[i-2]+dp[i-1] & dp[i-1]\cap dp[i] \leq 26
\end{cases}
$$
 
# Code
---
```cpp

void solve()
{
	while(true)
	{
		string n; cin >> n;
		if(n=="0") break;
		
		vector<unsigned ll> dp(n.length()+1,0);
		dp[0] = 1;
		dp[1] = 1;
		for(int i = 2; i <= n.length(); i++)
		{
			int twin = stoi(string(1,n[i-2]) + string(1,n[i-1]));
			int here = n[i-1]-'0';
			int back = n[i-2]-'0';
			
			if(here==0 and back==0) // impossible
			{
				dp[i] = 0;
				break;
			}
			
			if(here == 0) 
			{
				dp[i] = dp[i-2];
			}
			else if(back==0 or twin > 26)
			{
				dp[i] = dp[i-1];
			}
			else
			{
				dp[i] = dp[i-1] + dp[i-2];
			}
			
		}
		
		cout << dp.back();
		cout << "\n";
	}
}
```