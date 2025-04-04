#bio
# child's play
---
>[!summary] Pretty hard BIO Q3, from 2009


# Explanation
---
> [!warning]
> This question is **very** similar to [[all work no play]], but relies on a completely different method!

This question is a [[recursion|recursive]] [[dynamic programming]] problem. It is pretty similar to other *"find the nth value"* questions in the BIO such as [[false plan]], [[parking]], or even [[modern art]], with the difference here being that there is a variable length in the sequence. 

Luckily for us, whilst most variable-length sequences in the BIO are better off done without recursion, this one can be done pretty easily with it. This is because it isn't actually the length of the item that matters^[for example, in [[all work no play]] the sequence was practically ordered by length, and in [[new order]] the sequence relied on "magnitude" which relies on length] 

Rather, it is only the positioning of the elements that matters, to make bigger numbers, and not the length of the sequence itself, i.e the "dictionary order" of the sequence. 

Therefore, all we have to do is recurse all possibilities in a [[complete search]] from lowest to biggest, and ignore values that exceed our desired sum. 

We create a [[dynamic programming|dp]] array that stores the number of possibilities if the sum is at a certain point, and we use this to skip whole sections of the [[tree]] when we can guarantee that `n` doesn't lie within it. 

We can then, admittedly haphazardly, break out of the recursion and find our resultant string once we reach `n`. 

# Code
---
```cpp
int s, n;
ll dp[33];
string out = "";
bool stop = false;
ll compute(ll sum = 0, ll a = 1, string pre="")
{
	if(stop) return 0;
	if(sum > s) return 0;
	if(dp[sum] and a + dp[sum] <= n) return dp[sum];
	if(sum == s)
	{
		if(a==n){
			stop = true;
			out = pre;
		}
		return 1;
	}

	ll tot = 0;
	for(int i = 1; i <= 9; i++)
	{
		if(tot >= n) break;
		tot += compute(sum+i, a+tot, pre+string(1, '0'+i));
	}
	return dp[sum] = tot;
}


void solve()
{
	 cin >> s >> n;
	 compute();
	 
	 cout << out;
}
```