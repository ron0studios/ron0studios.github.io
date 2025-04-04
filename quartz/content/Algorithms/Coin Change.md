# Coin-Change problem
--------------------------------------------------------------------
>
Given **N** different coins, how can you make **X** with the sum of those coins? 
e.g if X is 3, and the coins are 1,2,3... you can do:
1 + 1 + 1
1 + 2
2 + 1
3

This is a popular [[dynamic programming]] problem, therefore it is classed as an algorithm, since this technique is used in many other problems.
In practice, you have an X+1 sized vector, where every value is 0 except for `X[0]` which is equal to 1 *(since the only way to make 0, with any number of coins, is just having no coins at all)*.
Then for each value of the array, we loop through every coin, and the value gets appended by the value of the current element minus the value of the coin. 

This is because:
> if the max number of combinations of 3, is 4, then the max number of 3+3 should include all the combinations of 3. If you do this to all the the coins, then it would work. You have to go from bottom to top.

## example code:
```c++
count[0] = 1;
for (int x = 1; x <= n; x++) {
	for (auto c : coins) {
		if (x-c >= 0) {
			count[x] += count[x-c];
		}
	}
}
```