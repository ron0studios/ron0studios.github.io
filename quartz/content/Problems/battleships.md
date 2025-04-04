#bio
# Battleships
---
> 2015 BIO problem 2
> (Problem statement is pretty long, check it out on their site)


# Explanation
---
good rule:
to convert from typical math coordinates to coding coordinates you do:

- swap the coordinates so that y becomes x and x becomes y
- for the new x coordinate do the following:
	- set the value to the number of grid rows minus 1 minus the new x coordinate

for example, if we were talking about a 10 by 10 grid, a c++ solution would look like
```cpp
	pair<int,int> x = mp(10-1-coords.second,coords.first);
```

This was another grid based problem *very* similar to [[four in a line]] with the main difference being it wasn't a simulation, and also the stranger coordinate set.


# Code
---
```cpp
vector<vector<int>> grid;
vector<pair<int,int>> delta = { {-1, 0}, {-1,1}, {0,1}, {1,1}, {1,0}, {1,-1}, {0,-1}, {-1,-1} };
int a,c,m,r = 0;

bool ok(pair<int,int> x) {return x.first >= 0 and x.second >= 0 and x.first < 10 and x.second < 10;}

bool allgood(pair<int,int> coords)
{
	// convert
	pair<int,int> x = mp(10-1-coords.second,coords.first);
	//cout << "converted " << coords.first << " " << coords.second << "  to   " << x.first << " " << x.second << endl;
	for(auto i : delta)
	{
		pair<int,int> j = x+i;
		if(ok(j) and grid[j.first][j.second] == 1)
			return false;
	}
	return true;
}

void fillgrid(vector<pair<int,int>> positions)
{
	for(auto coords : positions)
	{
		pair<int,int> x = mp(10-1-coords.second,coords.first);
		
		grid[x.first][x.second] = 1;

	}
}

void placeship(int size)
{
	while(true){
		r = ((a*r)+ c) % m;
		int x,y; 
		x = to_string(r).back() - '0';
		if(to_string(r).length() == 1) y = 0; else
			y = to_string(r)[to_string(r).length()-2] - '0';
		r = ((a*r)+ c) % m;


		vector<pair<int,int>> positions;
		bool verti = r%2;
		int ogx = x; int ogy = y;
		bool skip = false;
		for(int i = 0; i < size; i++)
		{
			if(!ok(mp(x,y))) continue;
			if(!allgood(mp(x,y))){skip=true;break;}
			positions.pb(mp(x,y));
			if(verti)
			{
				y += 1;
			}
			else
			{
				x += 1;
			}
		}
		if(skip) continue;

		cout << ogx << " " << ogy << " " << (verti ? 'V' : 'H') << "\n";
		fillgrid(positions);
		return;

	}
}

void solve(int tc)
{
	grid=vector<vector<int>>(10,vector<int>(10,0));
	r = 0;
	cin >> a >> c >> m;
	
	placeship(4); ;
	placeship(3);
	placeship(3);
	placeship(2);
	placeship(2);
	placeship(2);
	placeship(1);
	placeship(1);
	placeship(1);
	placeship(1);

	for(auto i : grid)
	{
		for(auto j : i)
		{
			cout << ( j==1 ? '#' : '.' ) << " ";
		}
		cout<<"\n";
	}
	
}
```