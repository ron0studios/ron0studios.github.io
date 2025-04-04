#bio
# Die tipping
---
> INSANELY time consuming bio problem (atleast 2.5 hours) 


# Explanation
---
This problem requires solid [[matrix]] skills, similar to [[four in a line]] but also requires the spatial awareness of the dice. 

# Code
---
```cpp

class Die{
	public:
		pair<int,int> heading;
		vector<pair<int,int>> headinglist = {{1,0},{0,1},{-1,0},{0,-1}};
		map<pair<int,int>,int> headingmap;

		int x;
		int y;
		
		Die(int positionX, int positionY, pair<int,int> orientation)
		{
			x = positionX;
			y = positionY;
			heading = orientation;
			headingmap[mp(1,0)] = 0;
			headingmap[mp(0,-1)] = 3;
			headingmap[mp(-1,0)] = 2;
			headingmap[mp(0,1)] = 1;
		}

		void tip(pair<int,int> dir)
		{
			//cout << "DIR: " << dir.first << " " << dir.second << "\n";
			if(dir == mp(1,0))
			{
				rotate_LR(true);
				return;
			}

			if(dir == mp(-1,0))
			{
				rotate_LR(false);
				return;
			}

			if(dir == mp(0,-1))
			{
				rotate_UD(true);
				return;
			}

			if(dir == mp(0,1))
			{
				rotate_UD(false); 
				return;
			}

		}

		void rotate(bool clockwise)
		{
			if(clockwise)
			{
				//cout << "before: " << heading.first<< " " << heading.second << "\n";
				heading = headinglist[(headingmap[heading]+1) % 4];
				//cout << "after: " << heading.first << " " << heading.second << "\n";
			}
			else // anticlockwise
			{ 
				int tmp = headingmap[heading] - 1;
				if(tmp<0) tmp = 3;
				heading = headinglist[tmp];
			}
		}

	void print()
	{
		//printf("top: %i, bottom: %i, left: %i, right: %i, up: %i, down: %i || VALID = %s\n",top_,bottom_,left,right,up,down,(_valid()?"TRUE":"FALSE"));
	}
	
	
	int top_ = 1;
	private:

		void rotate_LR(bool clockwise)
		{
			if(clockwise)
			{
				int tmp_left = left;
				int tmp_right = right;
				int tmp_top_ = top_;
				int tmp_bottom_ = bottom_;

				left = tmp_bottom_;
				top_ = tmp_left;
				right = tmp_top_; 
				bottom_ = tmp_right;
			}
			else // anticlockwise
			{
				int tmp_left = left;
				int tmp_right = right;
				int tmp_top_ = top_;
				int tmp_bottom_ = bottom_;

				left = tmp_top_;
				top_ = tmp_right;
				right = tmp_bottom_; 
				bottom_ = tmp_left;
			}
		}

		void rotate_UD(bool forward)
		{
			if(forward)
			{
				int tmp_up = up;
				int tmp_down = down;
				int tmp_top_ = top_;
				int tmp_bottom_ = bottom_;

				up = tmp_top_;
				bottom_ = tmp_up;
				down = tmp_bottom_;
				top_ = tmp_down;
			}
			else // backwards
			{
				int tmp_up = up;
				int tmp_down = down;
				int tmp_top_ = top_;
				int tmp_bottom_ = bottom_;

				up = tmp_bottom_;
				bottom_ = tmp_down;
				down = tmp_top_;
				top_ = tmp_up;
			}
		}

		bool _valid() // debug
		{
			if(top_ + bottom_ != 7) return false;
			if(left + right   != 7) return false;
			if(up   + down    != 7) return false;
			return true;
		}

		int bottom_ = 6;
		int left = 3;
		int right = 4;
		int up = 2;
		int down = 5;


};

void solve(int tc)
{
	vector<vector<int>> grid(11,vector<int>(11,1));
	for(int i = 4; i < 7; i++)
	{
		for(int j = 4; j < 7; j++)
		{
			cin >> grid[i][j];
		}
	}

	for(auto i : grid)
	{
		for(auto j : i)
			cout << j;
		cout << "\n";
	}
	cout << "\n\n\n";

	Die d(5,5,mp(0,-1));
	
	while(true)
	{
		int code; cin >> code;
		if(code == 0)
		{
			break;
		}
		else
		{
			for(int tmpc = 0; tmpc < code; tmpc++)
			{
				int modifier = grid[d.y][d.x] + d.top_; 
				if(modifier > 6) modifier -= 6; 
				grid[d.y][d.x] = modifier;

				//cout << "MOD" << modifier << "\n";
				if(modifier == 1 or modifier == 6)
				{
					d.x += d.heading.first;
					d.y += d.heading.second;
					d.tip(d.heading);
					if(d.x > 10) d.x = 0;
					if(d.y > 10) d.y = 0;
					if(d.x < 0) d.x = 10;
					if(d.y < 0) d.y = 10;
				}
				else if(modifier == 2)
				{
					//cout << "we doing this";

					d.print();
					d.rotate(true);
					d.x += d.heading.first;
					d.y += d.heading.second;

					d.tip(d.heading);
					if(d.x > 10) d.x = 0;
					if(d.y > 10) d.y = 0;
					if(d.x < 0) d.x = 10;
					if(d.y < 0) d.y = 10;
				}
				else if(modifier == 3 or modifier == 4)
				{
					d.rotate(true); d.rotate(true);

					d.x += d.heading.first;
					d.y += d.heading.second;
					d.tip(d.heading);
					if(d.x > 10) d.x = 0;
					if(d.y > 10) d.y = 0;
					if(d.x < 0) d.x = 10;
					if(d.y < 0) d.y = 10;
				}
				else if(modifier == 5)
				{
					d.rotate(false);

					d.x += d.heading.first;
					d.y += d.heading.second;
					d.tip(d.heading);
					if(d.x > 10) d.x = 0;
					if(d.y > 10) d.y = 0;
					if(d.x < 0) d.x = 10;
					if(d.y < 0) d.y = 10;
				}
				else
				{
					cout << "ERROR!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\n\n\n";
				}
			}
		}

		d.print();
		for(int i = d.y-1; i<=d.y+1; i++)
			{
				for(int j = d.x-1; j<=d.x+1; j++)
				{
					// cout << i << " "<< j << "\n\n\n\n\n\n\n\n\n";
					if(i > 10 or i < 0 or j > 10 or j < 0) cout <<"X";
					else
					cout << grid[i][j];
				}
				cout << "\n";
			}
		cout << "\n";
	
	}

}


```