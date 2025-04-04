#bio
# dots and boxes
---
> Relatively hard  BIO 2017 Q2 [[ad hoc|implementation]]


# Explanation
---
> [!important] I spent **way** too long on this question because I *misread* the very first part of the problem statement. My entire placement system was functional, but I didn't see that I had to give a player an extra turn if they did manage to place a box! 

This problem is a combination of a [[matrix|grid]] problem and a [[graph]] problem. I focused on the graph aspect, in managing the dots, whilst maintining a grid from where to highlight captured boxes. 
This problem is similar, in the grid aspect, to [[four in a line]], but in terms of its graphs its probably also similar to [[on the right track]], where edges have to be modified. 

# Code
```cpp


class Grid {
	public:
		int pos1, mod1, pos2, mod2; 
		bool move = 0;
		int turns;
		bool repeat = false;

		unordered_map<int,pair<int,int>> dotmap;
		vector<vector<int>> grid; 
		map<pair<int,int>,vector<pair<int,int>>> dotnodelist;

		Grid(int p1, int m1, int p2, int m2, int n){
			pos1  = p1;
			mod1  = m1;
			pos2  = p2;
			mod2  = m2;
			turns = n;

	
			grid    = vector<vector<int>>(5,vector<int>(5,0));

			for(int i = 1; i<=36; i++)
				dotmap[i] = mp( floor((i-1)/6), (i-1)%6);

		}


		void run() {

			//cout << pos1 << " " << pos2 << endl;
			while(true)
			{
				if(turns == 0) break;
				step();
				//cout << turns << endl;
				//usleep(50000);
				
				//cout << "turn completed"<< move << endl;
				
						/*
				for(auto i : dotnodelist)
				{
					cout << i.first.first << ":" << i.first.second << "   :::    ";
					for(auto j : i.second)
						cout << j.first << " " << j.second << " , ";
					cout << endl;
				}
				cout << pos1 << " " << pos2 << endl;
				*/
			}
		}

		void step(){
			if(move==0)
			{
				pos1 += mod1;
				if(pos1 > 36) pos1 -= 36; 

				pair<int,int> edge = validedge(pos1, move);
				while(edge == mp(-1,-1))
				{
					pos1 += 1; 
					if(pos1 > 36) pos1 -= 36; 
					edge = validedge(pos1, move);
				}
				
				pair<int,int> start = dotmap[pos1];

				// connect the dots;
				dotnodelist[start].pb(edge);
				dotnodelist[edge].pb(start);
			}
			else
			{
				pos2 += mod2;
				if(pos2 > 36) pos2 -= 36; 

				pair<int,int> edge = validedge(pos2, move);
				while(edge == mp(-1,-1))
				{
					pos2 += 1; 
					if(pos2 > 36) pos2 -= 36; 
					edge = validedge(pos2, move);
				}
				
				pair<int,int> start = dotmap[pos2];

				// connect the dots;
				dotnodelist[start].pb(edge);
				dotnodelist[edge].pb(start);
			}
			
			bool result = checkboxes();


			move = !move;
			turns --;

			if(result)
			{
				move = !move;
				
				while(result){
				if(turns==0) break;
				if(move==0)
				{
					pos1 += mod1;
					if(pos1 > 36) pos1 -= 36; 

					pair<int,int> edge = validedge(pos1, move);
					while(edge == mp(-1,-1))
					{
						pos1 += 1; 
						if(pos1 > 36) pos1 -= 36; 
						edge = validedge(pos1, move);
					}
					
					pair<int,int> start = dotmap[pos1];

					// connect the dots;
					dotnodelist[start].pb(edge);
					dotnodelist[edge].pb(start);
				}
				else
				{
					pos2 += mod2;
					if(pos2 > 36) pos2 -= 36; 

					pair<int,int> edge = validedge(pos2, move);
					while(edge == mp(-1,-1))
					{
						pos2 += 1; 
						if(pos2 > 36) pos2 -= 36; 
						edge = validedge(pos2, move);
					}
					
					pair<int,int> start = dotmap[pos2];

					// connect the dots;
					dotnodelist[start].pb(edge);
					dotnodelist[edge].pb(start);
				}
				
				result = checkboxes();
				turns--;
				}
				move = !move;
			}
	
		}

		bool checkboxes()
		{
			bool boxadded = false;
			for(int i = 0; i < 5; i++)
			{
				for(int j = 0; j < 5; j++)
				{
					if(isbox(mp(i,j)) and grid[i][j] == 0)
					{
						grid[i][j] = move + 1; 
						boxadded = true;
					}
				}
			}
			return boxadded;
		}

		bool isbox(pair<int,int> pos)
		{
			vector<pair<int,int>> dots; 
			dots.pb( pos + mp(0,0) );
			dots.pb( pos + mp(1,0) );
			dots.pb( pos + mp(0,1) );
			dots.pb( pos + mp(1,1) ); // ideally all of these are "ok()"
			int connections = 0;

			if(edgeswith(dots[0],dots[1]))
				connections += 1;
			if(edgeswith(dots[0],dots[2]))
				connections += 1;
			if(edgeswith(dots[3],dots[1]))
				connections += 1;
			if(edgeswith(dots[3],dots[2]))
				connections += 1;

			if( connections == 4){
				return true;
			}

			return false;
		}

		bool edgeswith(pair<int,int> a, pair<int,int> b)
		{
			for(auto i : dotnodelist[a])
				if( i == b)
					return true;
			for(auto i : dotnodelist[b])
				if( i == a)
					return true;
			return false;
		}

		pair<int,int> validedge(int pos, bool player)
		{
			pair<int,int> dotpos = dotmap[pos];
			
			vector<pair<int,int>> delta = { {-1,0}, {0,1}, {1,0}, {0,-1}};
			
			if(player){ // anticlockwise
				delta = { {-1,0}, {0,-1}, {1,0}, {0,1}};
			}
			
			for(auto i : delta)
			{
				pair<int,int> newpos = dotpos + i;
				if(dotok(newpos.first,newpos.second))
				{
					if(!edgeswith(dotpos,newpos)) {
						//cout << "valid " << endl;
						return newpos;
					}
				}
			}

			return mp(-1,-1); // false
		}

		void print()
		{
				for(auto i : grid)
				{
					for(auto j : i){
						if(j==0)
							cout << "* ";
						if(j==1)
							cout << "X ";
						if(j==2)
							cout << "O ";
					}
					cout << endl;
				}

				int p1c=0, p2c = 0;
				for(auto i : grid)
					for(auto j : i){
						if(j == 1)
							p1c++;
						if(j==2)
							p2c++;
					}
				cout << p1c<< " " <<p2c<< "\n";
		}
	private:

		bool dotok(int a, int b)
		{
			return a >= 0 and b >= 0 and a < 6 and b < 6;
		}


};

void solve(int tc)
{
	int p1, m1, p2, m2, n; cin >> p1 >> m1 >> p2 >> m2 >> n;

	Grid grid(p1,m1,p2,m2,n);
	grid.run();
	grid.print();
}


```
---