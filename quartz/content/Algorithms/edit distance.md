# Edit Distance
---
> You are given 2 strings, A and B. You are allowed to do 3 operations, insert a character at any point, delete any characters and replace any character. What are the minimum amount of operations required to transform string A into string B?


# Explanation
---
This is a very common [[dynamic programming]] problem, but it isnt easy! The trick is to treat subproblems as the first i letters of string a, and the first j letters of string b. Hence, we've essentially created a [[matrix]], similar to the [[coin-combinations II]] problem, in which we refer to previous rows of the matrix. 
The cell directly above a state will be considered as an insertion operation since, we're taking a state in which string a stays intact but string b has lost its last letter. 
A cell to the left of a state refers to deletion since we take the state where the original string has lost a letter. 
taking a diagonal will refer to replacement, since both have lost their last letter, so, intuitively, in this state, one letter must have been changed to the other.
If both letters are the same, we just take the diagonal of the state without adding 1, since nothing has changed in terms of operations.

# Code
---
```c++
void solve(int tc)
{
	string a,b; cin >> a >> b;
	vector<vector<int>> memo(a.length()+1, vector<int>(b.length()+1,0));
	
	for(int i = 0; i <= b.length(); i++) // row 1
		memo[0][i] = i;

	for(int i = 0; i <= a.length(); i++) // column 1
		memo[i][0] = i;

	for(int i = 1; i <= a.length(); i++)
	{
		for(int j = 1; j <= b.length(); j++)
		{
			if(a[i-1] == b[j-1]) // because i and j are shifted
			{
				memo[i][j] = memo[i-1][j-1];
			}
			else{
				memo[i][j] = min(memo[i-1][j], min(memo[i][j-1], memo[i-1][j-1])) + 1;
			}
		}
	}
	
	cout << memo.back().back() << "\n";
}
```