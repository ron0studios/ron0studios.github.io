#bio
# neutron
---
> A very tedious BIO 2013 Q2 [[ad hoc|implementation]]


# Explanation
---
This is yet another [[matrix|grid]] problem, more simulation heavy, similar to problems like [[Mu torere]] where a counter is moved around between players

# Code
---
```cpp

template <typename T,typename U>                                                   
std::pair<T,U> operator-(const std::pair<T,U> & l,const std::pair<T,U> & r) {   
    return {l.first-r.first,l.second-r.second};                                    
}

vector<pair<int,int>> delta = { {-1,0}, {-1,1}, {0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1} };
vector<vector<pair<char,int>>> grid;

bool ok(int a, int b) { return a >= 0 and b >= 0 and a < 5 and b < 5; }

void p_grid()
{
	for(auto i : grid)
	{
		for(auto j : i)
			cout << j.first << " ";
		cout << "\n";
	}
}

pair<int,int> move(pair<int,int> pos, pair<int,int> dir)
{
	while(true)
	{
		pos = pos + dir; 
		if(!ok(pos.first,pos.second))
			return pos - dir;
		if(grid[pos.first][pos.second].first != '-') 
			return pos - dir;
	}
}

bool canmove(pair<int,int> pos)
{
	for(auto i : delta)
	{
		if(move(pos,i) != pos)
		{
			return true;
		}
	}
	return false;
}

pair<int,int> find(pair<char,int> piece)
{
	for(int i = 0; i < 5; i++)
	{
		for(int j = 0; j < 5; j++)
		{
			if(grid[i][j] == piece){
				return mp(i,j);
			}
		}
	}
}

void solve(int tc)
{
	grid = vector<vector<pair<char,int>>>(5,vector<pair<char,int>>(5,mp('-',-1)));

	for(int i = 0; i < 5; i++)
		grid[0][i] = mp('2', i+1); 

	for(int i = 0; i < 5; i++)
		grid[4][i] = mp('1', i+1); 

	grid[2][2] = mp('N', -1); 

	vector<int> order1, order2; 
	inveci(5,order1) 
	inveci(5,order2)
	
	// the index of order1/2
	vector<vector<int>> orders = {order1,order2};
	vector<int> piecepos = {0,0}; // bcs you can put in "turn" as the index

	// test




	int turn = 0; // 0 is player 1
	
	while(true)
	{

		// pre strats (check if player can move
		if(!canmove(find(mp('N',-1)))){ p_grid(); return;}

		// strat 1
		for(auto i : delta)
		{
			pair<int,int> neutronpos = find(mp('N',-1));
			pair<int,int> newpos = move(neutronpos,i);
			if(turn == 0) {
				if(newpos.first == 4) 
				{
					grid[neutronpos.first][neutronpos.second] = mp('-',-1);
					grid[newpos.first][newpos.second] = mp('N',-1);

					p_grid();
					return; // victory!
				}
			}
			else
			{
				if(newpos.first == 0) 
				{
					grid[neutronpos.first][neutronpos.second] = mp('-',-1);
					grid[newpos.first][newpos.second] = mp('N',-1);

					p_grid();
					return; // victory!
				}
			}
		}

		// strat 2 (strat 1 must have not worked)
		bool strat2 = true;
		for(auto i : delta)
		{
			pair<int,int> neutronpos = find(mp('N',-1));
			pair<int,int> newpos = move(neutronpos,i);
			if(turn == 0) {
				if(neutronpos == newpos) // doesn't count because player couldnt move
					continue;
				if(newpos.first != 0) 
				{
					strat2 = false; // there is a possibility that doesn't lead to enemy winning
				}
			}
			else
			{
				if(neutronpos == newpos) // doesn't count because player couldnt move
					continue;
				if(newpos.first != 4) 
				{
					strat2 = false; 
				}
			}
			
		}
		if(strat2)
		{
			for(auto i : delta){
				pair<int,int> neutronpos = find(mp('N',-1));
				pair<int,int> newpos = move(neutronpos,i);
				if(neutronpos == newpos) 
					continue; 

				grid[neutronpos.first][neutronpos.second] = mp('-',-1);
				grid[newpos.first][newpos.second] = mp('N',-1);
				p_grid();
				return; // opponent wins
			}
		}

		// strat 3
		for(auto i : delta)
		{
			//cout << "movin\n";
			// move neutron in first dir that doesn't lead to the current piece from being unable to move
			pair<int,int> neutronpos = find(mp('N',-1));
			pair<int,int> newpos = move(neutronpos,i);

			if(newpos == neutronpos) continue;
			if(newpos.first == 4 or newpos.first == 0) continue;
			grid[neutronpos.first][neutronpos.second] = mp('-',-1);
			grid[newpos.first][newpos.second] = mp('N',-1);

			if(!canmove(find(mp('0'+turn+1,orders[turn][piecepos[turn]]))))
			{
				grid[neutronpos.first][neutronpos.second] = mp('N',-1);
				grid[newpos.first][newpos.second] = mp('-',-1);
			}
			else{

				break;
			}
		}
		for(auto i : delta)
		{
			pair<int,int> piece = find(mp('0'+turn+1,orders[turn][piecepos[turn]]));
			pair<int,int> newpos = move(piece,i);
			if(newpos == piece)
				continue;
			grid[piece.first][piece.second] = mp('-',-1);
			grid[newpos.first][newpos.second] = mp('0'+turn+1, orders[turn][piecepos[turn]]);
			break;
		}


		/*
	    cout << "Player: " << turn << "\n";
		cout << "done 3\n";
		p_grid();
		cout << "\n-----------\n";
		*/
		piecepos[turn] = (piecepos[turn] + 1) % 5;
		turn = !turn;
	}


	p_grid();

}


```