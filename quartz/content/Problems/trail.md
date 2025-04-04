#bio
# trail
---
> Pretty generous BIO 2019 Q2 [[ad hoc|implementation]]


# Explanation
---
This is yet another class-based, [[matrix|grid]] problem, the movement system is similar to [[die tipping]] with the major difference being that the "player" itself has no state^[like how a die had to know which side up it was].  The trail, furthermore, had to be recorded on an infinite grid.

This problem is made more trivial by abstracting away the grid itself and focus only on the points of the trail. This is something you should always try to do when tackling an infinite grid.
# Code
---
```cpp

class Trail {
	public:
		int max_trail;
		string instructions;
		int steps_made = 0;
		int moves; 
		map<pair<int,int>, int> trail;
		pair<int,int> cur_dir = mp(-1,0);
		pair<int,int> cur_pos = mp(0,0);

		vector<pair<int,int>> dirs;
		bool endgame = false;

		Trail(int t, string i, int m)
		{
			max_trail = t;
			instructions = i;
			moves = m;
			dirs = {{-1,0},{0,1},{1,0},{0,-1}};
		}

		void run(){
			while(true){
				if(moves == 0) break;
				if(endgame) break;
				step();
			}
		}

		void step(){
			char command = instructions[steps_made % instructions.length()];
			if(command == 'L')
			{
				rotate(-1);
			}
			else if(command == 'R')
			{
				rotate(1);
			}

			int fails = 0;

			while(trail.count(cur_pos + cur_dir)){
				if(fails > 4){
					//cout << "got stuck";
					
					endgame = true; return;
				}
				rotate(1);
				fails ++;
			}

			trail[cur_pos] = 0;
			update_trail();
			cur_pos = cur_pos + cur_dir;
			moves--;
			steps_made++;
		}

		void display(){
			pair<int,int> newpos = mp(cur_pos.second,cur_pos.first);
			newpos.second = -newpos.second;
			cout << newpos.first << " " << newpos.second << "\n";
		}

		void update_trail(){
			vector<pair<int,int>> mark_delete;
			for(auto &i : trail)
			{
				i.second++;
				if(i.second >= max_trail)
				{
					mark_delete.pb(i.first);
				}
			}
			for(auto i : mark_delete){
				trail.erase(i);
			}
		}

		void rotate(int amt)
		{
			map< pair<int,int>, int> conv = {{{-1,0},0},{{0,1},1},{{1,0},2},{{0,-1},3}};

			if(amt < 0) {
				int i = conv[cur_dir]+amt;
				if(i<0) i = 3;
				cur_dir = dirs[i];
			}
			else{
				cur_dir = dirs[ (conv[cur_dir]+amt) % 4 ];
			}
		}
};

void solve(int tc)
{
	int t;
	string s;
	int m;
	cin >> t >> s >> m;
	Trail trail(t,s,m);
	trail.run();
	trail.display();

}
```