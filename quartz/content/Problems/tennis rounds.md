# tennis rounds
---
>[!summary] UVA-12643. Pretty simple somewhat [[maths|mathsy]] problem (took ~10 mins)

# Explanation
---
To solve this problem, you loop through the powers of 2 until you find a power which, when dividing both contestants, yields the same divider. 
To be more concise, if both `a/ 2**i` and `b / 2**i`  are the same, then we conclude both `a` and `b` are in the same bracket, within round `i`. 

# Code^[added the `main` function because this question weirdly doesn't include an input for the number of test cases 🤔]
---
```cpp
void solve(int n, int a, int b)
{
	a--; b--;
	//cout << n << " "  << a << " "  << b << endl;
	for(int bracket = 1; bracket <= n; bracket++){
		int size = pow(2, bracket);
		int apos = a / size;
		int bpos = b / size;
		if(apos == bpos)
		{
			cout << bracket << endl;
			return;
		}

	}
}

int main()
{
    ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0);
	int a,b,c;
    while(cin >> a >> b >> c)
    {
        solve(a,b,c);
    }
    return 0;
}
```