# Jollo
---
>[!summary] UVA 12247. A pretty logicky problem but can be approached systematically


# Explanation
---
This requires a good hand at [[game theory]] in principle, but you don't **really** need it in this scenario. Its moreso just another [[ad hoc]] problem.

The trick here is to realise if you want to guarantee player 2's^[the prince] success, you will need to simulate the game in the perspective where player 1^[the princess] plays optimally. This occurs when player 1 plays the next biggest card it has against each card player 2 plays. For example if player 1 has cards of value 20 and 30, whilst player 2 has a card of value 10, player 1 should play card 20. 
If there are no cards bigger than the card player 2 plays, then player 1 should expend its lowest value card, i.e. to minimise losses. 
In order to make this simulation even more worst-case scenario, we ensure player 2 makes the worst possible moves, by starting from playing its smallest cards first.

After player 2 has exhausted 2 cards, i.e. when it only has 1 card leftover - the one the dealer is supposed to decide that guarantees player 2's success - player 1 will also have 1 remaining card. If the score so far, in this worst case scenario, is a tie for both players, the card that guarantees player 2s success should be at least 1 greater than this remaining player 1 card, and not currently in play by either players.
If the score is 2-0 for player 1, in this worst case scenario, then there is no possible card that player 2 can play to win this game, meaning there is no possible card for player 2 to play for it to guarantee winning every game scenario. 
If the score is 0-2 for player 2, in this worst case scenario, then player 2 can allow itself to be complacent and lose this point, meaning it can play the lowest possible card that exists, that isnt already in play by either players. 
# Code
---
```cpp
void solve(int a, int b, int c, int x, int y)
{
	vector<int> abc = {a,b,c}; sort(abc.begin(), abc.end());
	vector<int> xy  = {min(x,y),max(x,y)};
	vector<int> pool = {a,b,c,x,y};


	if(a==b or b==c or c==x or x==y) {
		cout << -1 << endl; return;
	}
	if(xy[0] < abc[1] and xy[1] < abc[2]){
		cout << -1 << endl;  return;
	}

	int p1,p2; p1=p2=0;

	for(int i = 0; i < 3; i++)
	{
		if(abc[i] > xy[0]){
			abc.erase(abc.begin()+i);
			p1++;
			break;
		}
	}
	xy.pop_back();
	if(abc.size() == 3){
		p2++;
		abc.erase(abc.begin());
	}

	for(int i = 0; i < 2; i++)
	{
		if(abc[i] > xy[1]){
			p1++;
			abc.erase(abc.begin()+i);
			break;
		}
	}
	xy.pop_back();
	if(abc.size() == 2){
		p2++;
		abc.erase(abc.begin());
	}

	if(p1==p2){
		int out = abc[0]+1;
		while(find(pool.begin(), pool.end(), out) != pool.end()){
			out++;
		}
		if(out > 52)
			out = -1;
		cout << out << endl;

	}
	else if(p2 == 2) {
		//int pos = find(pool.begin(), pool.end(), abc[0])-pool.begin();
		int out = 1;
		while(find(pool.begin(), pool.end(), out) != pool.end()){
			out++;
		}
		if(out > 52)
			out = -1;
		cout << out << endl;
	}
}
```
