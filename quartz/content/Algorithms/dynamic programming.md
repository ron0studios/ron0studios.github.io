---
alias: DP
---
# Dynamic programming
>
Dynamic programming is the technique of caching, or saving the results of an algorithm to help speed up time complexity, such as saving the results of subproblem states, or pre-processing all possible results beforehand etc. 

## Memoization
memoization is the field of dynamic programming where data is saved in a recursive fashion, usually in recursive algorithms. This usually involves a base case statement which returns a value, ending the recursion, a check for the existance of the element already in the saved data memo, and then the recursive call to fill in the next parts of the memo. 

The data is *usually* filled from **top to bottom** ^[that is that the input data is positive, then the recursion fills the table downwards until a base case of 0]

## Tabulation
Tabulation is the field of dynamic programming where data is saved in either an array-like structure or perhaps a [[matrix]], initially as empty, but then filled completely up to the input data, and then an answer is given by looking up the matrix. This method is faster since it avoids the recursive calls, and call stacks, alongside other features of functions that can slow down the program. 
It can also be made faster by calculating all results within the bounds of the input, before even inputting the test cases, essentially making the algorithm itself constant time. ^[sort of, since we are still going to have to compute **ALL** of the values in a table within the bounds, which could be up to INT_MAX of around 2 billion.]

The data is *usually* filled from **bottom to top**

>[!warning] look out!
> if you're running multiple test cases, make sure to **clear out** the dp structure before redoing it!!!!

---
## <center>techniques/tips</center>
---


### When you want to find the **minimum/maximum** of something
For tabulation, what you can do is have an array and for each state transition, add 1, to include the current state. An example of this would be coin change, where we take $dp[x]$ and $dp[x-i]$ for all coins of size $i$ and find the min/max of all of them, and then add 1 to the end, i.e $min(dp[x-i]+1\ ,\ ...)$$. 


### When you want to find the total amount of something
What you would do is the same as finding the \frac{*minimum}{maximum*, except **you don't add 1** to the end. What you are essentially doing is branching a [[complete search]] tree. 

When you want to find distinct amounts, such as distinct combinations, you need to make your array 2 dimensional and consider whether you want to include something or not. refer to [[coin-combinations II]]. 

