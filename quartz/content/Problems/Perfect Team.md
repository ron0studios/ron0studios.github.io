# Perfect Team
---
>[!summary] Surprisingly easy 1200 rated problem. Misleading binary search tag


# Explanation
---
For this question, the maximum number of `teams` is equal to the maximum number of coder/maths member pairs, since every team requires atleast one of each. If there is a high enough number of unspecialised members, then it will just be the minimum of the number of coders or mathematicians. 

However, if there is not enough specialised members then we need to floor divide the total by 3. Why?
for each pair of coders and mathematicians, we detract 2 from the total. Say the total starts at 10, therefore our table of possibilities looks something like this.

| teams | left | needed |
| ----- | ---- | ------ |
| 1     | 8    | 1      |
| 2     | 6    | 2      |
| 3     | 4    | 3      |
| 4     | 2    | 4      |
| 5     | 0    | 5      |

Notice how `teams` and `needed` are equivalent. This is because for every new team, only one more member is needed, the third team member. 
Our ideal solution is the closest values of `left` and `needed` to each other without needed being greater than left. For the above example, the answer is 3 teams.

In other words, we should say we are trying to minimise $left-needed$, without the value being negative. The result of the subtraction goes down by 3 each time, so we can simplify the table to the equation $$y=total-3(teams)$$
where $y$ is the value we are trying to optimise. Since we want y to be 0, we solve for $$\begin{gather} 0=total-3(teams) \\ 3(teams) = total \\ teams = \frac{total}{3}\end{gather} $$
Therefore, we floor $\frac{total}{3}$ to get our result. The minimum of this result and `min(c,m)` is our answer.

# Code
---
```cpp
void solve(int tc)
{
	int c,m,x; cin >> c >> m >> x;
	int tot = c+m+x;
	cout << min(tot/ 3, min(c,m)) << endl;
}
```