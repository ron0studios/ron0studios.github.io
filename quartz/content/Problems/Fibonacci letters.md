#bio
# Fibonacci letters
---
> Annoying BIO 2011 Q1.  [[ad hoc|implementation]]


# Explanation
---
You need to first use 1-indexing instead of 0, in order to add numbers in the sequence. You also need to convert back to a char after dealing with ints. 

# Code
---
```cpp

int val(char inp)
{
	return 'A'-inp + 1;
}

void solve(int tc)
{
	char inp1,inp2; cin>>inp1>>inp2;
	int a = inp1 - 'A' +1; 
	int b = inp2 - 'A' +1; 
	cout << a << " " << b << "\n";
	int n; cin >> n;
	vector<int> dp(1200000,-1);
	dp[0] = a; dp[1] = b;
	for(int i = 0; i<dp.size()-5; i++)
	{
		dp[i+2] = dp[i] + dp[i+1];
		if(dp[i+2]>26)dp[i+2]-=26;
	}

	cout << (char)('A' + dp[n-1] - 1) << "\n";

}
```