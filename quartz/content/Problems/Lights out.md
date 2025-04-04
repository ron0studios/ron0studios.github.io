# Lights out
https://codeforces.com/problemset/problem/275/A
#implementation
>
Lenny is playing a game on a 3 × 3 grid of lights. In the beginning of the game all lights are switched on. Pressing any of the lights will toggle it and all side-adjacent lights. The goal of the game is to switch all the lights off. We consider the toggling as follows: if the light was switched on then it will be switched off, if it was switched off then it will be switched on.
>
Lenny has spent some time playing with the grid and by now he has pressed each light a certain number of times. Given the number of times each light is pressed, you have to print the current state of each light.
>
Input
>
The input consists of three rows. Each row contains three integers each between 0 to 100 inclusive. The _j_-th number in the _i_-th row is the number of times the _j_-th light of the _i_-th row of the grid is pressed.
>
Output
>
Print three lines, each containing three characters. The _j_-th character of the _i_-th line is "1" if and only if the corresponding light is switched on, otherwise it's "0".

```
## Code
This can be simply simulated by creating the 3x3 [[matrix]] and carrying out the set of operations.
```c++
// this solution brute-forcishely simulates the problem with each cell
void solve(int tc)
{
	//input and prerequisites
	vector<vector<int>> x(3,vector<int>(3,0));
	for(int i = 0; i < 9; i++)
		cin >> x[floor(i/3)][i%3];
	vector<vector<int>> out(3,vector<int>(3,1));
	
	//for each cell in the table
	for(int i = 0; i < 3; i++)
	{
		for(int j = 0; j < 3; j++)
		{
			//Repeat K many times. toggle all adjacent cells
			for(int k = 0; k < x[i][j]; k++)
			{
				out[i][j] = !out[i][j];
				for(auto l : {mp(1,0),mp(-1,0),mp(0,1),mp(0,-1)})
				{
					if(i+l.first < 3 && j+l.second < 3 && i+l.first >=0 && j+l.second>=0)
					{
						out[i+l.first][j+l.second] = !out[i+l.first][j+l.second];
					}
				}
			}
		}
	}
	//answer
	for(auto i : out)
	{
		for(auto j : i)
		{
			cout << j;
		}
		cout << "\n";
	}
}
```