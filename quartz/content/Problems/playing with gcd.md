# playing with gcd
---
>[!summary] A quirky codeforces problem


# Explanation
---
This is a problem based on [[Greatest Common Divisor|GCD]].

Essentially since everything's a factor, we can start working from back to front in a [[Greedy]] approach. 

You create the array `b` first, of length n+1, filled with zeroes. Set the first element to the first number. 

The second number is equal to the LCM of the first 2 numbers^[note that in the special case where $N=1}$ we just say "YES"]. 

From that point onwards for every $i$, we have to find a number that makes it so that  `b[i], b[i+1]` makes the GCD of `nums[i]` and also meets the requirement that `b[i+1]` is a multiple of `nums[i+1]`. 

To do this what we do is we fill `b[i+1]`, by finding the LCM of `nums[i]` and `nums[i+1]`. If the GCD of this number and `b[i]` is equal to `nums[i]` then we can continue and increment `i` in the loop. 
However, if this is not the case, we have guaranteed that we will never be able to find a number later down the line that will satisfy this case and the array is impossible, so we say "NO".

You can verify this yourself, think about the example `4 2 4`. 
Running the algorithm for the first indice yields us a b list of `4 4`. For the next index however, the LCM of 2 and 4, is 4, and the GCD of 4 and 4 is also 4, which is not 2^[what a tongue twister, sorry :D]. Even if tried other common multiples, like 8 and 12, the limiting factor is the 2nd element, 4, leading to the GCD always being 4, hence the b array is impossible to create.

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<int> nums(n,0);
	for(int i = 0; i < n; i++)
		cin >> nums[i];

	vector<int> out(n+1,0);


	if(n == 1) {
		cout << "YES\n";
		return;
	}

	for(int i = 0; i < n; i++)
	{

		if(i == 0) {
			out[i] = nums[i];
			int j = max(nums[i],nums[i+1]);
			while(j % min(nums[i], nums[i+1])) j += max(nums[i],nums[i+1]);
			out[i+1] = j;
		}
		else if(i == n-1)
		{
			out[n] = nums[n-1];
		}
		else
		{
			int j = max(nums[i],nums[i+1]);
			while(j % min(nums[i], nums[i+1])) j += max(nums[i],nums[i+1]);
			if(gcd(j, out[i]) != nums[i]){
				cout << "NO\n"; return;
			}
			out[i+1] = j;
		}
	}

	cout << "YES\n";

}


```