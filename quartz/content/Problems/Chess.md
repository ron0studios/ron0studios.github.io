# Chess
---
>[!summary] UVA 278. Pretty simple, as long as you can whip out a chessboard sketch to figure out the different cases


# Explanation
---
This is a chess related [[ad hoc]] problem, very similar to [[chessboard and queens]] in principle, but much more simplified, and numeric.
### Rooks
The case for rooks is the simplest. It will always just be a diagonal of rooks along the chessboard, so the minimum of the height or width of the board, i.e $min(m,n)$ 

### knights
The knight scenario can be solved by placing all knights on the same coloured squares on the chess board. This is because each of the attacking squares of a knight is always in a different coloured square to the knight itself. Since for every possible chessboard size the number of white and black squares are equal, the maximum number of place-able knights is always $\frac{nm}{2}$.

### Kings
The King scenario is a bit weirder. By default the king occupies a 3x3 space around it, but by placing the king in one of the corners of the board we can reduce this to 2x2. By placing the kings horizontally on every other square we can ensure no two kings are threatening each other. If we repeat the process vertically we will end up having a grid of kings spaced 1 apart. The resulting formula to calculate the total number of kings in this fashion on an n by m board, we use $$ \lceil\frac{n}{2}\rceil\lceil\frac{m}{2}\rceil$$
### Queens
The queens scenario is the trickiest. Refer to the [8 queens problem](https://en.wikipedia.org/wiki/Eight_queens_puzzle) on wikipedia to understand how exactly we could place the queens or why this works mathematically. However, for the scope of this question, all we need to know is the maximum number of queens we can place for a certain board size. 
Surprisingly enough, since the queen follows the same rule as the rook horizontally, the maximum number on an m by n board is also the minimum of the two dimensions, i.e. $min(m,n)$ 

# Code
---
```cpp
void solve(int tc)
{
	char type; cin >> type;
	int m; cin >> m;
	int n; cin >> n;

	switch (type){
		case 'r':
			cout << min(m,n) << endl;
			break;
		case 'k':
			cout << ceil((m*n)/2.0) << endl;
			break;
		case 'Q':
			cout << min(m,n) << endl;
			break;
		case 'K':
			cout << ceil(m/2.0)*ceil(n/2.0) << endl;
			break;
	}
}
```