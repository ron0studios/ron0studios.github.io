#bio
# Mu torere
---
> A much much harder version of [[four in a line]]


# Explanation
---


# Code
---
```cpp
vector<char> symb = {'O','X'};

// can the given player move?
bool canmove(string board, int move)
{
	char marker = symb[move]; 
	for(int i = 1; i < 9; i++)
	{
		if(board[i] == marker) 
		{
			int left = (i-1 < 1) ? 8 : i-1; 
			int right = (i+1 > 8) ? 1 : i+1; 

			if(board[left] == marker and board[right] == marker)
				continue;
			else{
				if(board[0] == 'E' or board[left] == 'E' or board[right] == 'E')
					return true;
			}

		}
	}
	if(board[0] == marker) // because there MUST be a gap somewhere to move to
		return true; 

	return false;
}

string place(string board, int from, int to)
{
	char tmp = board[from];
	board[from] = board[to]; 
	board[to] = tmp;
	return board;
}

vector<int> neighbours(int x)
{
	vector<int> out; 
	if(x == 0)
	{
		for(int i = 1; i < 9; i++)
		{
			out.pb(i);
		}
	}
	else
	{
		int left = (x-1 < 1) ? 8 : x-1; 
		int right = (x+1 > 8) ? 1 : x+1; 

		out.pb(0); // the center is technically the leftmost 
		out.pb(left);
		out.pb(right);
	}
	return out; 
}

// can the player move a current piece from a to b?
bool canplace(string board, int from,int to)
{
		int left = (from-1 < 1) ? 8 : from-1;  // kawai neighbours
		int right = (from+1 > 8) ? 1 : from+1; //
		if(board[left] == board[from] and board[right] == board[from])
		{
			return false;
		}
		if(board[to]!='E') // if the location already has a marker
			return false;

		return true;
}

//								    only run rule 1
string step(string board, int move, bool only1=false)
{
	char marker = symb[move];
	string tmp = board; 

	// simulate rule 1
	for(int i = 0; i < 9; i++) // includes center
	{
		if(tmp[i] == marker)
			for(auto j : neighbours(i)) // loop through neighbours, and try out the move
			{
				if(!canplace(tmp,i,j))
					continue;

				tmp = place(tmp,i,j); 
				if(!canmove(tmp,!move)) // if the opponent can't move (i.e they lose)
				{
					//cout << "rule1\n";
					return tmp; 
				}
				tmp = board; // reset if the move is useless
			}
	}
	if(only1)
		return "none";


	// simulate rule 2
	for(int i = 0; i < 9; i++)
	{
		if(tmp[i] == marker)
			for(auto j : neighbours(i)){
				if(!canplace(tmp,i,j))
					continue;

				tmp = place(tmp,i,j); 
				if(step(tmp,!move,true)=="none") // if simulating your opponent's 
				{							 // move after yours doesn't lead to them winning

					//cout << "rule2\n";
					return tmp;
				}
				tmp = board; 
			}
	}

	// inevitable loss (rule 3)
	for(int i = 0; i < 9; i++)
	{
		if(tmp[i] == marker)
		{
			for(auto j : neighbours(i)){
				if(!canplace(tmp,i,j))
					continue; 

				tmp= place(tmp,i,j);

				//cout << "rule3\n";
				return tmp; 
			}
		}
	}

	// rule 4, you f'ed up 
	cout << "ERROR!"; 
}

// mu torere
void solve(int tc)
{
	string board; cin >> board; 
	map<string,bool> done;
	done[board] = true;

	int turn = 0; 
	while(true)
	{
		string inp; cin >> inp; 
		if(inp == "n")
		{
			// in case the very first input is the end
			if(!canmove(board,0)){
				cout << board << "\n";
				cout << "Player 2 wins!\n"; return;
			}
			if(!canmove(board,1)){
				cout << board << "\n";
				cout << "Player 1 wins!\n"; return;
			}

			board = step(board, turn);
			cout << board << "\n";
			if(done[board])
			{
				cout << "Draw!\n"; return;
			}
			else
			{
				done[board] = true;
			}

			if(!canmove(board,0)){
				cout << "Player 2 wins!\n"; return;
			}
			if(!canmove(board,1)){
				cout << "Player 1 wins!\n"; return;
			}

			turn = !turn;
		}
		else // r
		{
			while(true)
			{

				board = step(board, turn);
				if(done[board])
				{
					cout << "Draw!\n"; return;
				}
				else
				{
					done[board] = true;
				}

				if(!canmove(board,0)){

					cout << board << "\n";
					cout << "Player 2 wins!\n"; return;
				}
				if(!canmove(board,1)){

					cout << board << "\n";
					cout << "Player 1 wins!\n"; return;
				}

				turn = !turn;
			}
		}
	}

}


```