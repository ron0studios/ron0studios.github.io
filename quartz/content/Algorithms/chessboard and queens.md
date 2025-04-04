# chessboard and queens
---
>[!summary] Very common [[complete search]] problem  (cses)

# Explanation
---
This problem uses [[complete search#Recursively|recursive complete search]] in order to backtrack and find the correct answer. It goes row by row (since you can't ever have 2 queens in the same row), and places a queen in every valid position.

A valid position, in this case, is one where the location is free and not blocked. It is also one where there are no other queens able to reach it. 

For the latter, we could use a function to traverse the grid in all 8 directions to check the board, but this is pretty clunky. A better solution is to create 3 arrays, one for each column, and two for the two types of diagonals in the [[matrix|grid]]. If a queen is placed, we temporarily mark its respective column and diagonals as taken, by setting the vector positions to true. This is how the vectors are represented:

![[image-20220810072318892.png]]

> Notice in the code and the image how we need to find out the correct diagonals. diag1 (diagTR) is determined by summing the row and index, whilst diag2 (diagBR) is determined by subtracting the row from the index and adding the width of the grid minus 1. 


# Code
---
```cpp
vector<vector<int>> grid;
vector<bool> column;
vector<bool> diagTR;
vector<bool> diagBR;
int out = 0;

void compute(int row)
{
	if(row==8)
	{
		out++; return;
	}

	for(int i = 0; i < 8; i++)
	{
		if(grid[row][i] == 0)
		{
			if(column[i] || diagTR[i+row] || diagBR[i-row+7]) continue;
			column[i] = diagTR[i+row] = diagBR[i-row+7] = true;
			compute(row+1);
			column[i] = diagTR[i+row] = diagBR[i-row+7] = false;
		}
	}
}

void solve()
{
	grid = vector<vector<int>>(8,vector<int>(8,0));
	column = diagTR = diagBR = vector<bool>(20,false);
	for(int i = 0; i < 8; i++)
	{
		for(int j = 0; j < 8; j++)
		{
			char x; cin >> x;
			if(x=='*') {
				grid[i][j] = 1;
			}
		}
	}
	out = 0;
	compute(0);
	cout << out << "\n";
}
```