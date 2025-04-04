# Chessboard in FEN
---
>[!summary] UVA 10284. A pretty standard [[ad hoc]] [[matrix|grid]] problem though I took the most hard-codey possible approach 🤦‍♂. took around 1 hour 30 to 2 hours


# Explanation
---
This problem's style resembles quite a few **BIO1 problem 2s**, namely in its *game-like* implementation approach, namely [[four in a line]], [[pentominoes]], and [[battleships]], but also [[L-shapes]] from codeforces. 

### Parsing the FEN notation
This was pretty easy. Just have to split the string into an array called `rows`, using `/` as the delimiter.

### Representing the grid
For the grid representation, I use an 8x8 *vector* of chars. The possible states for the char are:
- 0^[raw value, not the char '0'], for an unoccupied square.
- 1^[raw value, not the char '1'], for an unoccupied square being threatened by any piece. 
- 'p','r','n','b','q','k', for their respective *black* pieces.
- 'P','R','N','B','Q','K', for their respective *white* pieces.

### Highlighting the attacked squares
We know that  the raw value `1` represents an unoccupied square that is being attacked or threatened by one of the pieces on the board, but how do we determine which squares those are? What we can do, being often the case for these kind of **BIO2**esque problems, is to create a `delta` value, being an array of coordinate **pairs**.
The `delta` value, in addition (literally) with the position of a piece can determine all the different coordinates that said piece can reach on an empty board. 
Of course not all `delta` values are legal in this case. For example, a rook on a starting position cannot move anywhere whilst the delta values say it can move across to its adjacent corners on the board. This is because chess pieces, save the knight, cannot attack pieces being obstructed by at least one other piece. Since I decided to go with the `delta` approach instead of using a bunch of `for` loops, it made my job a bit more difficult with stopping checks that have obstructed pieces within them. 
To fix this, I organised the `delta` values such that they are sorted primarily by direction and internally in ascending order. Since all long distance pieces, namely the queen, bishop and rook are only able to go 8 squares in any direction (due to limitations of the board being 8x8), what we can do is simply skip the `for` loop iterator to the next "group" in the `delta` array for that piece when we detect any form of obstruction. This means any subsequent checks in the same direction that go beyond a certain distance get skipped. 
To do this I use the line `k=(k/8)*8 + 7`, which essentially floor divides k by 8 to find which direction of the `delta` check we are in, multiplies by 8 to get to the very first index of that group, adds 8 to get to the next one, and then subtract 1 because the iterator gets incremented at the end of the loop.

### Finding safe squares
This is now very easy. Simply loop through each square in the board and count up each square with a raw char value of 0.

# Code
---
```cpp

bool ok(pair<int,int> pos){
	if(pos.first < 8 and pos.second < 8 and pos.first >= 0 and pos.second >= 0)
		return true;
	return false;
}

void solve(string fen)
{
	vector<vector<char>> board(8, vector<char>(8, 0));
	vector<string> rows;
	int tmpptr = 0;
	while(tmpptr < fen.size()){
		int nxt = fen.find('/',tmpptr);
		rows.pb(fen.substr(tmpptr, nxt-tmpptr));
		if(nxt == string::npos) {
			tmpptr = fen.size();
		}
		else tmpptr = nxt+1;
	}


	for(int i =0 ; i < 8; i++)
	{
		int ptr = 0;
		for(int j = 0; j < rows[i].size(); j++)
		{
			if(isdigit(rows[i][j])){
				ptr += rows[i][j]-'0';
			}
			else{
				board[i][ptr] = rows[i][j];
				ptr++;
			}
		}
	}

	map<char, vector<pair<int,int>>> deltas;
	deltas['n'] = {
		mp(2,1),
		mp(2,-1),
		mp(-2,1),
		mp(-2,-1),
		mp(1,2),
		mp(1,-2),
		mp(-1,2),
		mp(-1,-2)
	};
	deltas['r'] = {
		mp(0,1), mp(0,2), mp(0,3), mp(0,4), mp(0,5), mp(0,6), mp(0,7), mp(0,8),
		mp(0,-1), mp(0,-2), mp(0,-3), mp(0,-4), mp(0,-5), mp(0,-6), mp(0,-7), mp(0,-8),
		mp(1 ,0), mp(2 ,0), mp(3 ,0), mp(4 ,0), mp(5 ,0), mp(6 ,0), mp(7 ,0), mp(8 ,0),
		mp(-1,0), mp(-2,0), mp(-3,0), mp(-4,0), mp(-5,0), mp(-6,0), mp(-7,0), mp(-8,0)
	};
	deltas['b'] = {
		mp(1,1), mp(2,2), mp(3,3), mp(4,4), mp(5,5), mp(6,6), mp(7,7), mp(8,8),
		mp(1,-1), mp(2,-2), mp(3,-3), mp(4,-4), mp(5,-5), mp(6,-6), mp(7,-7), mp(8,-8),
		mp(-1,1), mp(-2,2), mp(-3,3), mp(-4,4), mp(-5,5), mp(-6,6), mp(-7,7), mp(-8,8),
		mp(-1,-1), mp(-2,-2), mp(-3,-3), mp(-4,-4), mp(-5,-5), mp(-6,-6), mp(-7,-7), mp(-8,-8)
	};
	deltas['q'] = {
		mp(1,1), mp(2,2), mp(3,3), mp(4,4), mp(5,5), mp(6,6), mp(7,7), mp(8,8),
		mp(1,-1), mp(2,-2), mp(3,-3), mp(4,-4), mp(5,-5), mp(6,-6), mp(7,-7), mp(8,-8),
		mp(-1,1), mp(-2,2), mp(-3,3), mp(-4,4), mp(-5,5), mp(-6,6), mp(-7,7), mp(-8,8),
		mp(-1,-1), mp(-2,-2), mp(-3,-3), mp(-4,-4), mp(-5,-5), mp(-6,-6), mp(-7,-7), mp(-8,-8),
		mp(0,1), mp(0,2), mp(0,3), mp(0,4), mp(0,5), mp(0,6), mp(0,7), mp(0,8),
		mp(0,-1), mp(0,-2), mp(0,-3), mp(0,-4), mp(0,-5), mp(0,-6), mp(0,-7), mp(0,-8),
		mp(1 ,0), mp(2 ,0), mp(3 ,0), mp(4 ,0), mp(5 ,0), mp(6 ,0), mp(7 ,0), mp(8 ,0),
		mp(-1,0), mp(-2,0), mp(-3,0), mp(-4,0), mp(-5,0), mp(-6,0), mp(-7,0), mp(-8,0)
	};
	deltas['k'] = {
		mp(1,0),
		mp(0,1),
		mp(-1,0),
		mp(0,-1),
		mp(1,1),
		mp(-1,1),
		mp(1,-1),
		mp(-1,-1)
	};
	deltas['p'] = {
		mp(1,1),
		mp(1,-1)
	};


	for(int i = 0; i < 8; i++)
	{
		for(int j = 0; j < 8; j++)
		{
			if(board[i][j] < 2) continue;
			if(tolower(board[i][j]) == 'p'){
				if(islower(board[i][j])){
					for(auto k : deltas['p']){
						if(!ok(k+mp(i,j))) continue;
						pair<int,int> pos = k+mp(i,j);
						if(board[pos.first][pos.second] == 0) 
							board[pos.first][pos.second] = 1;
					}
				} else {
					for(auto k : deltas['p']){
						if(!ok(mp(-k.first,-k.second)+mp(i,j))) continue;
						pair<int,int> pos = mp(-k.first,-k.second)+mp(i,j);
						if(board[pos.first][pos.second] == 0) 
							board[pos.first][pos.second] = 1;
					}
				}
			}
			else {
				for(int k = 0; k < deltas[tolower(board[i][j])].size(); k++){
					if(!ok(deltas[tolower(board[i][j])][k]+mp(i,j))) continue;
					pair<int,int> pos = deltas[tolower(board[i][j])][k]+mp(i,j);
					if(board[pos.first][pos.second] < 2) 
						board[pos.first][pos.second] = 1;
					else {
						switch(tolower(board[i][j])){
							case 'r':
								k = ((k/8)*8)+7;
								break;
							case 'q':
								k = ((k/8)*8)+7;
								break;
							case 'b':
								k = ((k/8)*8)+7;
								break;
						}
					}
				}
			}
		}
	}

	int out = 0;
	for(int i = 0; i < 8; i++)
	{
		for(int j = 0; j < 8; j++)
		{
			if(board[i][j] == 0)
			{
				out++;
			}
		}
	}
	cout << out << endl;
}
```