# cow tipping
---
>[!summary] Pretty hard Usaco bronze question 3 


# Explanation
---
> [!info] 
> This is a pretty strange [[Greedy]] problem. Here's an explanation to how you'd go about solving it.

First an observation:
- Notice how there are $N^2$ different rectangles that can toggle the topleft square, but there is only $1$ rectangle that can toggle the bottomright square^[the whole rectangle]. 

What we can now do, basically, is that we can greedily solve for each cell!

Here's how it would work:
- You would first check the bottom-right square and see if it needs toggling^[i.e is it a $1$ or not], and toggle it if it is.
- The square to the left of it now only has one rectangle that can toggle it, see if that square needs toggling, and toggle it if it does. 
- Once the bottom row is done, you've now essentially created a leftover rectangle at the top (a subproblem) in which you can repeat the algorithm.

# Code
---
```cpp
void solve()
{
	freopen("cowtip.in","r",stdin);
	freopen("cowtip.out","w",stdout);
	int n; cin >> n;
	vector<vector<int>> grid(n,vector<int>(n,0));
	for(int i = 0; i < n; i++)
	{
		for(int j = 0; j < n; j++)
		{
			char x; cin >> x;
			grid[i][j] = x-'0';
		}
	}

	int c = 0;
	for(int i = n-1; i >= 0; i--){
		for(int j = n-1; j >= 0; j--)
		{
			if(grid[i][j] == 1)
			{
				for(int k = 0; k <= i; k++)
				{
					for(int l = 0; l <= j; l++)
					{
						grid[k][l] = !grid[k][l];
					}
				}
				c++; // lol
			}
		}
	}

	cout << c;
}
```