# snakes and ladders
---
>[!summary] UVA 11459. A relatively simple [[ad hoc]] [[matrix|grid]] problem that can be abstracted to a much simpler array problem. Took around 30 minutes


# Explanation
---
This is a game simulation problem, resembling many of the **BIO1 q2** problems, such as the plugboarding problem in [[turing machine]]. 
We maintain 3 vectors, one that maps each player to their current position on the board, in the form `playerpos[player] = position`. 
We need a vector to maintain the routes, where each of the 100 cells are mapped with either -1 for having no route or a positive integer which will be the position the player goes to if they land on that index. 
Lastly we need a vector of all the roll values, as given in the input. The reason we cant just take the roll values as input one by one in the loop in line`22` is because there is a chance that one of the players finishes the game early before all the rolls have been exhausted, meaning we will have leftover input to take in in out `stdin` stream, which will impact any future test cases, leading us to inputting the wrong numbers.
# Code
---
```cpp
void solve(int tc)
{
	int players, snadders, rolls;
	cin >> players >> snadders >> rolls;

	vector<int> playerpos(players,0);
	vector<int> routes(100, -1);
	vector<int> movelist(rolls,0);

	for(int i = 0; i < snadders; i++)
	{
		int a,b; cin >> a >> b;
		routes[a-1] = b-1;
	}

	for(int i =0 ; i < rolls; i++)
	{
		cin >> movelist[i];
	}

	int curplayer = 0;
	for(int i = 0; i < rolls; i++)
	{
		playerpos[curplayer] += movelist[i];
		if(routes[playerpos[curplayer]] >= 0) {
			playerpos[curplayer] = routes[playerpos[curplayer]];
		}
		if(playerpos[curplayer] == 99){
			break;
		}
		curplayer = (curplayer + 1) % players;
	}

	for(int i = 0; i < players; i++)
	{
		cout << "Position of player " << i+1 << " is " << playerpos[i]+1 << "." << endl;
	}
}
```