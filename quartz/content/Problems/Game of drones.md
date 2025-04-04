#bio
# Game of drones
---
>[!summary] Ultra hard BIO Q2 


# Explanation
---
This thing was **hard** and unreasonable for a BIO round 1 question.

From discord:
> basically the hardest part of the question was finding out how to find a preferred edge in a feud, since it relies on so many priorities, especially when a lot of the values are the same. 
There is a neat c++ datastructure for sorting with multiple elements known as a pair, which sorts by its first elements, and differentiates the same first number with the pair's second number.
You can do a similar thing in python by calculating the hexagons gained, hexagons taken from opponent, hex pos and edge pos of an edge, and convert it into a string of letters (since all the values are between 0 and 26 i think). 
And then you can have python sort the array of words (array of all possible choices a drone can make) as usual, alphabetically. 
this should significantly cut down on the if statements you have to use!

# Code
---
```cpp

class Hex {
	public:
		vector<int> sides;
		int control = 0;
		Hex()
		{
			sides = vector<int>(6,0);
		}
};

class HexGrid {
	public:
		vector<vector<Hex>> grid;
		int redjump, bluejump;
		int redpos, bluepos; 
		int reddir, bluedir; 
		int skirmishes, feuds; 

		HexGrid(int r, int b, int s, int f)
		{
			grid = vector<vector<Hex>>(5,vector<Hex>(5, Hex()));
			redjump = r;
			bluejump = b;
			skirmishes = s;
			feuds = f;
			redpos = 0; reddir = 0;
			bluepos = 24; bluedir = 5;
		}


		void skirmish()
		{
			// DO RED DRONE
			// conquer current edge
			pair<int,int> redcoord = pos2coord(redpos);
			grid[redcoord.first][redcoord.second].sides[reddir] = 1;
			pair<int,int> altRed = findAlt(mp(redcoord.first, redcoord.second), reddir);
			if(ok(altRed.first, altRed.second)) grid[altRed.first][altRed.second].sides[(reddir+3)%6] = 1;
			// move red
			redpos = (redpos + redjump) % 25;
			reddir = (reddir + 1) % 6;

			// DO BLUE DRONE
			// conquer current edge
			pair<int,int> bluecoord = pos2coord(bluepos);
			grid[bluecoord.first][bluecoord.second].sides[bluedir] = 2;
			pair<int,int> altBlue = findAlt(mp(bluecoord.first,bluecoord.second), bluedir);
			if(ok(altBlue.first, altBlue.second)) grid[altBlue.first][altBlue.second].sides[(bluedir+3)%6] = 2;
			// move blue
			bluepos = (bluepos + bluejump) % 25;
			bluedir = (bluedir - 1);
			if(bluedir < 0) bluedir += 6;


			updateHexes();

			skirmishes--;
		}

		void feud()
		{
			// DO RED DRONE
			//         hexes    taken   hexnum edgenum
			vector<pair<int,pair<int,pair<int,int>>>> optionsRed;
			
			// try all UNOWNED edges 
			for(int i = 0; i < 25; i++)
			{
				for(int j = 0; j < 6; j++)
				{
					pair<int,int> coord = pos2coord(i);
					if(grid[coord.first][coord.second].sides[j] != 0) continue;
					int hexes, taken, hexnum, edgenum;
					hexnum = -i; edgenum = -j; // to sort by lowest
					pair<int,int> dHex = hexChange(i ,j , 1);
					hexes = dHex.first;
					taken = -dHex.second; 
					optionsRed.pb(mp(hexes,mp(taken,mp(hexnum,edgenum))));
				}
			}
			sort(optionsRed.begin(),optionsRed.end());

			pair<int,pair<int,pair<int,int>>> redChoice = optionsRed.back();
			pair<int,int> redcoord = pos2coord(-redChoice.second.second.first);
			int redside = -redChoice.second.second.second;
			grid[redcoord.first][redcoord.second].sides[redside] = 1;
			pair<int,int> altRed = findAlt(mp(redcoord.first, redcoord.second), redside);
			if(ok(altRed.first, altRed.second)) grid[altRed.first][altRed.second].sides[(redside+3)%6] = 1;

			
			/*
			for(auto i : optionsRed)
			{
				cout << i.first << " " << i.second.first << " " << i.second.second.first << " " << i.second.second.second << endl;
			}
			*/
			
			updateHexes();

			// DO BLUE DRONE
			vector<pair<int,pair<int,pair<int,int>>>> optionsBlue;
			
			// try all UNOWNED edges 
			for(int i = 0; i < 25; i++)
			{
				for(int j = 0; j < 6; j++)
				{
					pair<int,int> coord = pos2coord(i);
					if(grid[coord.first][coord.second].sides[j] != 0) continue;
					int hexes, taken, hexnum, edgenum;
					hexnum = i; edgenum = j; // to sort by lowest
					pair<int,int> dHex = hexChange(i ,j , 2);
					hexes = dHex.first;
					taken = -dHex.second; 
					optionsBlue.pb(mp(hexes,mp(taken,mp(hexnum,edgenum))));
				}
			}
			sort(optionsBlue.begin(),optionsBlue.end());

			pair<int,pair<int,pair<int,int>>> blueChoice = optionsBlue.back();
			pair<int,int> bluecoord = pos2coord(blueChoice.second.second.first);
			int blueside = blueChoice.second.second.second;
			grid[bluecoord.first][bluecoord.second].sides[blueside] = 2;
			pair<int,int> altBlue = findAlt(mp(bluecoord.first, bluecoord.second), blueside);
			if(ok(altBlue.first, altBlue.second)) grid[altBlue.first][altBlue.second].sides[(blueside+3)%6] = 2;


			updateHexes();

			int rc, bc; rc = bc = 0;
			for(auto i : grid)
			{
				for(auto j : i)
				{
					if(j.control == 1) rc++;
					if(j.control == 2) bc++;
				}
			}
			feuds--;
		}

		// tells change in control by taking edge
		//  team not-team
		pair<int,int> hexChange(int hex, int edge, int team)
		{
			int other = not (team-1); other++;
			pair<int,int> change = mp(0,0);
			vector<vector<Hex>> grid_copy = grid;

			pair<int,int> coord = pos2coord(hex);
			grid_copy[coord.first][coord.second].sides[edge] = team;
			pair<int,int> altCoord = findAlt(coord ,edge);
			if(ok(altCoord.first, altCoord.second)) grid_copy[altCoord.first][altCoord.second].sides[(edge+3)%6] = team;

			// check first hex
			int rc1 = 0, bc1 = 0;
			for(auto i : grid_copy[coord.first][coord.second].sides)
			{
				if(i == 1) rc1++;
				if(i == 2) bc1++;
			}
			int control1 = 0; 
			if(rc1 > bc1) control1 = 1;
			else if(bc1 > rc1) control1 = 2;
			else control1 = 0;
			int realcontrol1 = grid_copy[coord.first][coord.second].control;
			
			if(realcontrol1 == 0 and control1 == team)
			{
				change.first ++;
			}
			else if(realcontrol1 == other and control1 == team)
			{
				change.first ++; 
				change.second --;
			}
			else if(realcontrol1 == other and control1 == 0)
			{
				change.second --; 
			}

			if(!ok(altCoord.first, altCoord.second)) return change;

			// check second hex
			int rc2 = 0, bc2 = 0;
			for(auto i : grid_copy[altCoord.first][altCoord.second].sides)
			{
				if(i == 1) rc2++;
				if(i == 2) bc2++;
			}
			int control2 = 0; 
			if(rc2 > bc2) control2 = 1;
			else if(bc2 > rc2) control2 = 2;
			else control2 = 0;
			int realcontrol2 = grid_copy[altCoord.first][altCoord.second].control;
			
			if(realcontrol2 == 0 and control2 == team)
			{
				change.first ++;
			}
			else if(realcontrol2 == other and control2 == team)
			{
				change.first ++; 
				change.second --;
			}
			else if(realcontrol2 == other and control2 == 0)
			{
				change.second --; 
			}

			return change;
		}

		void updateHexes()
		{
			for(int i = 0; i < 5; i++)
			{
				for(int j = 0; j < 5; j++)
				{
					int rc = 0; int bc = 0;
					for(auto edge : grid[i][j].sides)
					{
						if(edge == 1) rc++;
						if(edge == 2) bc++;
					}

					if(rc > bc) grid[i][j].control = 1;
					else if(bc > rc) grid[i][j].control = 2;
					else grid[i][j].control = 0;
				}
			}
		}


		pair<int,int> pos2coord(int x)
		{
			return mp(floor(x/5), x - (floor(x/5)*5));
		}

		pair<int,int> findAlt(pair<int,int> curpos, int curdir)
		{
			switch(curdir)
			{
				case 0:
					return curpos + mp(-1, (curpos.first % 2 ) ? 1 : 0);
				case 1:
					return curpos + mp(0,1);
				case 2:
					return curpos + mp(1, (curpos.first % 2 ) ? 1 : 0);
				case 3:
					return curpos + mp(1, (curpos.first % 2 ) ? 0 : -1);
				case 4:
					return curpos + mp(0,-1);
				case 5:
					return curpos + mp(-1, (curpos.first % 2 ) ? 0 : -1);
				default:
					cout << "error";
					return mp(-1,-1);
			}
		}

		bool ok(int a, int b)
		{
			return a >= 0 and b >= 0 and a < 5 and b < 5;
		}

};

void solve(int tc)
{
	int r,b,s,f; cin >> r >> b >> s >> f;
	HexGrid grid(r,b,s,f);
	for(int i = 0; i < s; i++)
		grid.skirmish();
	for(int j = 0; j < f; j++)
		grid.feud();

	int rc, bc; rc = bc = 0;
	for(auto i : grid.grid)
	{
		for(auto j : i)
		{
			if(j.control == 1) rc++;
			if(j.control == 2) bc++;
		}
	}
	cout << rc << " " << bc;
}
```