#bio
# ZigZag numbers
---
>[!summary] **hard** BIO final problem q2 (1999)


# Explanation
---
This requires a good does of [[recursion]] and [[dynamic programming]]. Whilst it *is* very similar to [[modern art]] and [[Problems/parking]]

Ok so, to begin with, we should start by finding a way to generate all zigzag numbers in the first place. The best way to do this is using recursion. 

Here are the things we need to keep track of in our recursive state:
- the current string (pref)
- which numbers we've already used (mask)
- the last number/value in the string (last)

The first and last one could be combined into one, but it would be annoying to keep converting and for the sake of clarity we'll stick to keeping them seperate.

If you've seen the code, you may be confused as to how the `mask` variable keeps a track of the used numbers. Well, this takes use of [[bitwise operations]], and [[bitset DP]]. 
What looks like an `int` at first glance is, in reality, being used as a binary number, where each position of the number represents whether a particular number in the zigzag has been used or not.  

For example this:

| 8   | 7   | 6   | 5   | 4   | 3   | 2   | 1   |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0   | 1   | 1   | 0   | 0   | 1   | 0   | 1   |

means that the values $7,6,3\text{ and }1$  have already been used. If we want to check whether a certain value of the bitmask has already been used, we just shift the binary to the right, and see whether the new number is odd or even, `(mask >> i) % 2`. 
We then use the `|` operator with `1 << i`, to the new mask after a number is used. 

We would then, for each possible number less than or greater than `last`^[depending on whether `pref.length()` is even or not, to make it a zigzag], recurse to every possible state. e.g for a number where `last=1`, and no other numbers have been used up, we would try `2,3,4 and 5`. 
If we then were to recurse to `1,2`, we would find that there would be no more possibilities, since there is no number less than 2 thats not already been used up.
however, for `1,3`, we still have the possibility of recursing to `2`. 

Once `pref.length() == b`, we will have found a complete zigzag number. This will recurse all zigzag numbers in order.

However, there are wayy too many recursive steps involved when we have to deal with larger values of b, such as 15. In this case we have to start using [[dynamic programming]]. 

### DP state
---
The state of our DP will be very similar to our recursive state. it will consist of a number, for the position in the string, the mask, and the last value of the zigzag at that point, in the format:
```cpp
//     l : mask : last
int dp[15][32768][15];
```

Now can you see why we used bitmasks instead of arrays? It would have been wayyyy too space inefficient. This time, we just have a bitmask up to `32768`, because $2^{15} = 32768$.

For each state, we'll be storing the number of possibilites that arise from that state. For example, the state for `l=0, mask=0, last=0`, would just be the total number of zigzag numbers. 

We'll be using this dp to skip recurses that are less than our desired $N^{th}$ zigzag number. 

### DP execution
---
Now we have the state how do we use it?
Surprisingly, the DP in this problem isnt too bad!

First lets just set all values in the DP array to `-1`, to signify it hasnt been set yet. 

Now, we'll also need to include an extra variable in our recursive function, which is `ll pos`. This will signify the starting position of each branch. For example, in the base case scenario^[when we have a finished string], our `pos`, will simply just  be the position of that zigzag number out of all zigzag numbers in alphabetical order. 
i.e for the very first zigzag number of `b=5`, `13254`, will have a `pos` of 0. 
But, the state, where `pref=2`, would have a pos of `5`, because the first zigzag number starting with `2`, is the 5th zigzag number `23154`. 

Now for each instance of the function:
- If our DP lookup table already has a value saved for the state we're in, then we can simply return the number of possibilities that this state will return^[since we've already computed it earlier]. 
- **However**, what about if $N$ is within that state? Then we would have just skipped our $N^{th}$ zigzag number due to returning early. In this case, we should only use this if $pos+dp[a][b][c] < n$.
- Once we've finished branching to all the different states from a function, we should save the resulting returned value to our dp structure!

# Code
---
```cpp

string points = "123456789abcdef";
int b; ll n;
string out = "";


//     l : mask : last
int dp[15][32768][15];

ll compute(ll pos, int mask, int last, string pref="")
{
	//	cout << pref << endl;
	if(pref.length()==b){
		// n-1, because 1 based indexing
		if(pos==n-1) cout << pref << endl;//<< " : " << pos << endl;
		return 1;
	}

	if(dp[pref.length()][mask][last] != -1 and pos+dp[pref.length()][mask][last] < n)
	{
		return dp[pref.length()][mask][last];
	}

	bool down = pref.length() % 2; // next number higher or lower?
	
	ll x = 0;
	if(!down) {
		for(int i = 0; i < last; i++)
		{
			if((mask >> i) % 2) continue; 
			if(pos+x > n) break;
			x += compute(pos+x, mask | (1 << i), i, pref+points[i]);
		}
	}
	else {
		for(int i = last; i < b; i++)
		{
			if((mask >> i) % 2) continue;
			if(pos+x > n) break;
			x += compute(pos+x, mask | (1 << i), i, pref+points[i]);
		}
	}

	dp[pref.length()][mask][last] = x;
	
	return x;
}

void solve(int tc)
{
	out = "";
	cin >> b >> n;
	memset(dp,-1,sizeof(dp));
	compute(0,0,b);
}


```