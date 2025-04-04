# Infinity Table

>
Polycarp has found a table having an infinite number of rows and columns. The rows are numbered from 1, starting from the topmost one. The columns are numbered from 1, starting from the leftmost one.
>
Initially, the table hasn't been filled and Polycarp wants to fix it. He writes integers from 1 and so on to the table as follows.
>
![](https://espresso.codeforces.com/aa1eece2e042a16fcbc09f2af100e73049fd8841.png)
The figure shows the placement of the numbers from 1 to 10. The following actions are denoted by the arrows.
>
The leftmost topmost cell of the table is filled with the number 1. Then he writes in the table all positive integers beginning from 2 sequentially using the following algorithm.
>
First, Polycarp selects the leftmost non-filled cell in the first row and fills it. Then, while the left neighbor of the last filled cell is filled, he goes down and fills the next cell. So he goes down until the last filled cell has a non-filled neighbor to the left (look at the vertical arrow going down in the figure above).
>
After that, he fills the cells from the right to the left until he stops at the first column (look at the horizontal row in the figure above). Then Polycarp selects the leftmost non-filled cell in the first row, goes down, and so on.
>
A friend of Polycarp has a favorite number k. He wants to know which cell will contain the number. Help him to find the indices of the row and the column, such that the intersection of the row and the column is the cell containing the number k.
>
Input
The first line contains one integer t (1≤t≤100) — the number of test cases. Then t test cases follow.
>
Each test case consists of one line containing one integer k (1≤k≤109) which location must be found.
>
Output
For each test case, output in a separate line two integers r and c (r,c≥1) separated by spaces — the indices of the row and the column containing the cell filled by the number k, respectively.


## Code
As shown by the problem, this can be defined as an infinite [[matrix]]. with a layer-like pattern coming from the top left of the matrix. Here is the solution:
```c++
void solve(int tc)
{
	long long k; cin >> k; 
	long long r,c;  // Rows, Columns
	int c1 = 1; // index for what layer of the matrix we're in
	long long c2 = 1; // temporary
	
	// keep squaring (going down a row in the first column)
	// until c2 is greater than k, in which we found the layer
	while(c2<k)
	{
		c1++;
		c2 = c1*c1;
	}
	
	// stop program early if we already found the answer (row=c1, column=1)
	if(c2 == k)
	{
		cout << c1 << " 1\n"; return;
	}
	
	//total, the total number of squares in this layer of the matrix
	//calculated by doubling c1, like an offset, and substracting 1 (corner)
	long long t = c1 + c1 - 1;
	
	//The value of the first number in the layer, calculated by getting the
	//square value of the previous layer, and adding 1 
	long long first = ((c1-1)*(c1-1))+1;
	
	//The offset of k from the first value
	long long pos = (k-first);

	// if the position is less than c1, we can say that K is in the righthand
	// side of the layer, therefore c = the layer, and r is equal to the
	// distance from the outermost layer that the pos is.
	// If the position is greater, then K is in the same row but a different 
	// column, in the bottom side of the layer. R would just be c1, and c is
	// equal to the distance of pos from the T (the total)
	if(pos < c1)
	{
		r = c1 - ( c1-pos ) + 1;
		c = c1;
	}
	else
	{
		r = c1;
		c = (t-pos) ;
	}
	cout << r << " " << c << "\n";
}
```