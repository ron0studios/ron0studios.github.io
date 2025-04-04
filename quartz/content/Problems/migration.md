#bio
# migration
---
> A fun BIO 2016 Q2 [[ad hoc|implementation]]


# Explanation
---
An important consideration for this question is that migration can occur outside the grid, as there is technically an infinitely large plane upon which the migration can happen. This is very similar to the concept of [[Problems/waves]], and is much more easily done with a clean structure such as a class.  

# Code
---
```cpp

class Migration {
	public:
		int p,s,n;
		vector<vector<int>> spawn; 
		vector<int> seq;
		int spawnpos = 0;
		int previous;
		int steps_done = 0;
		map<pair<int,int>,int> people;

		Migration(int p1, int s1, int n1, vector<int> init) {
			p = p1;
			s = s1;
			n = n1;
			seq = init;
		}

		void run(){
			while(steps_done != n) 
				step();
			
			vector<vector<int>> toprint(5,vector<int>(5,0));
			for(int i = 0; i < 5; i++)
			{
				for(int j = 0; j < 5; j++)
				{
					cout << people[mp(i,j)] << " ";
				}
				cout << "\n";
			}
		}

		void step(){
			
			int newloc = seq[spawnpos];
			spawnpos = (spawnpos + 1) % seq.size(); 
			if(steps_done == 0) {
				newloc = p; 
				spawnpos = 0;
			}
			else {
				newloc += previous;
			}
			if(newloc > 25) newloc -= 25;
			previous = newloc;
			pair<int,int> nextperson = spawn2pos(newloc);

			people[nextperson]++;

			while(true)
			{
				vector<pair<int,int>> to_migrate = findcrowded();
				if(to_migrate.size() == 0) break;

				for(auto i : to_migrate){
					migrate(i);
				}
			}
			//print_people(); 
			steps_done ++; 
		}

		void migrate(pair<int,int> cell) {
			people[cell] -= 4;
			vector<pair<int,int>> delta = { {-1,0}, {0,1}, {1,0}, {0,-1} };
			for(auto i : delta)
			{
				people[cell + i] += 1;
			}
		}

		vector<pair<int,int>> findcrowded()
		{
			vector<pair<int,int>> out; 
			for(auto i : people)
			{
				if(i.second >= 4)
					out.pb(i.first);
			}
			return out;
		}

		pair<int,int> spawn2pos(int x)
		{
			for(int i = 0; i < 5; i++)
			{
				for(int j = 0; j < 5; j++)
				{
					x--;
					if(x == 0)
					{
						return mp(i,j);
					}
				}
			}
		}

		void print_people(){
			for(auto i : people)
			{
				cout << i.first.first << " "<< i.first.second << "  :  " << i.second << "\n";
			}
			cout << "-------------------------------\n";
		}

};

void solve(int tc)
{
	int p,s,n; cin >> p >> s >> n;
	vector<int> sequence; inveci(s,sequence);
	Migration out(p,s,n,sequence);
	out.run();
}


```