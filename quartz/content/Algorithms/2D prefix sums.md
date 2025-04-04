# 2D prefix sums
---
>[!summary] An important [[prefix sum]] implementation for more complex [[range query| range queries]]


# Explanation
---
A regular [[prefix sum#The prefix sum array|prefix sum array]] usually only sums up values in a 1D array. However, sometimes we have to deal with 2D arrays and find a sum within it. 
Take this question for example
>[!question]- CSES Forest queries
> <iframe src="https://cses.fi/problemset/task/1652/" width="100%" height="1000em" style="filter: invert(); "></iframe>

Now this problem asks us to essentially count the total sum within a certain bounded box of the grid. But before we calculate this, we need to find out, *how do we generate the prefix sum in the first place?*. 

Here is the algorithm: 
$$
prefix[x][y] = prefix[x-1][y] + prefix[x][y-1]-prefix[x-1][y-1]
$$
If we don't substract $[x-1][y-1]$ then we end up with an answer too big, due to the overlapping of the other two elements
![[image-20220807092312581.png]]

And now, in order to calculate the prefix of a [[matrix|sub-matrix]], we need to essentially take $prefix[x_2][y_2]$, and remove all the unnecesary sections, by masking. 

Here is the algorithm for a bounded box between $(x_1,y_1)$ and $(x_2,y_2)$
$$
A=prefix[x_2][y_2]-prefix[x_1-1][y_2]-prefix[x_2][y_1-1]+prefix[x_1-1][y_1-1]
$$

Now the reason why we add $[x_1-1][y_1-1]$ is because there is an overlap between the two substracting sections, meaning that our answer would be *less* than what we need.
![[image-20220807092820731.png]]


 
# Code
---
```cpp

void solve()
{
	int n,q; cin >> n >> q;

	vector<vector<int>> prefix(n+1,vector<int>(n+1,0));
	for(int i = 1; i <= n; i++)
		for(int j = 1; j <= n; j++){
			char inp; cin >> inp;
			prefix[i][j] = (inp=='*') ? 1 : 0; 
			prefix[i][j] = prefix[i][j] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1];
		}

	vector<vector<int>> queries(q,vector<int>(4,0));
	for(int i = 0; i < q; i++)
		for(int j = 0; j < 4; j++)
			cin >> queries[i][j];

	for(auto query : queries)
	{
		int x1 = query[0];
		int y1 = query[1];
		int x2 = query[2];
		int y2 = query[3];

		cout << prefix[x2][y2] - prefix[x2][y1-1] - prefix[x1-1][y2] + prefix[x1-1][y1-1] << "\n";
	}

}

```