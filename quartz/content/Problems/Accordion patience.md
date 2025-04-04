#bio 
# Accordion patience
---
> A quite difficult BIO 2011 Q2. 


# Explanation
---
This problem is a card / playing cards problem which requires conversion to [[string|strings]] for each card. 
It is a strange, branching [[ad hoc|implementation]] problem similar to [[four in a line]] or [[Mu torere]] where you have to simulate the best possible move that gets the best possible answer for the move after it, meaning you need a temporary board to apply the move to, in order to see into future moves
# Code
---
```cpp

vector<string> deck;
vector<vector<string>> piles; 


// pile 1 is left, pile 2 is right
bool valid(int pile1, int pile2, vector<vector<string>> pile = piles)
{
	if(pile2-pile1 != 1 and pile2-pile1 != 3){
		cout << "NOPE" << endl;
		return false;
	}
	if(pile1 < 0) return false; 

	string top1 = pile[pile1].back();
	string top2 = pile[pile2].back();
	if(top1[0] == top2[0]) // same value
		return true;
	if(top1[1] == top2[1]) // same suit
		return true;
	return false;
}

int n_valid(vector<vector<string>> pile)
{
	int count = 0;
	for(int i = pile.size()-1; i >= 1; i--)
	{
		if(valid(i-1,i,pile))
			count++;
		if(valid(i-3,i,pile))
			count++;
	}
	return count;
}

void solve(int tc)
{
	// clubs
	deck.pb("AC");
	for(int i = 2; i <= 9; i++)
		deck.pb(to_string(i)+"C");
	deck.pb("TC");
	deck.pb("JC");
	deck.pb("QC");
	deck.pb("KC");

	// hearts
	deck.pb("AH");
	for(int i = 2; i <= 9; i++)
		deck.pb(to_string(i)+"H");
	deck.pb("TH");
	deck.pb("JH");
	deck.pb("QH");
	deck.pb("KH");


	// spades
	deck.pb("AS");
	for(int i = 2; i <= 9; i++)
		deck.pb(to_string(i)+"S");
	deck.pb("TS");
	deck.pb("JS");
	deck.pb("QS");
	deck.pb("KS");


	// diamonds
	deck.pb("AD");
	for(int i = 2; i <= 9; i++)
		deck.pb(to_string(i)+"D");
	deck.pb("TD");
	deck.pb("JD");
	deck.pb("QD");
	deck.pb("KD");


	//shuffling and initial piles
	vector<int> nums; inveci(6,nums);
	vector<vector<string>> ogpiles;

	while(true)
	{
		bool done = false;
		for(auto x : nums)
		{
			if(deck.size() == 0) {
				done = true; break;
			}
			for(int i = 0; i < x-1; i++)
			{
				deck.pb(deck[0]);
				deck.erase(deck.begin());
			}
			// x'th element
			piles.pb(vector<string>());
			piles.back().pb(deck[0]);
			deck.erase(deck.begin());
		}
		if(done) break;
	}

	ogpiles = piles; // for reset
	cout << piles[0][0] << " " << piles.back()[0] << "\n";

	// strat1
	while(true){
		if(piles.size() == 1) break; //win
		bool movemade = false;
		for(int i = piles.size()-1; i >= 1; i--)
		{
			bool validadj = valid(i-1,i);
			bool validsep = valid(i-3,i);

			if(validadj)
			{
				piles[i-1].insert(piles[i-1].end(),piles[i].begin(),piles[i].end());
				piles.erase(piles.begin()+i); 
				i = piles.size(); movemade = true; break;
			}
			if(validsep)
			{
				piles[i-3].insert(piles[i-3].end(),piles[i].begin(),piles[i].end());
				piles.erase(piles.begin()+i); 
				i = piles.size(); movemade = true; break;
			}
		}

		if(!movemade) //lose
			break;
	}
	cout << piles.size() << " " << piles[0].back() << "\n";

	piles = ogpiles; 

	// strat 2 (largest pile possible)
	while(true){

		if(piles.size() == 1) break; //win
		bool movemade = false;
		int largest = -1; 
		int index_largest = -1;
		bool is_adj = false;

		// find biggest num;
		for(int i = piles.size()-1; i >= 1; i--)
		{
			bool validadj = valid(i-1,i);
			bool validsep = valid(i-3,i);
			if(validadj or validsep) movemade = true;

			if(validadj)
			{
				int newsize = piles[i].size() + piles[i-1].size();
				if(newsize > largest)
				{
					largest = newsize; 
					index_largest = i; 
					is_adj = true;
				}
			}
			if(validsep)
			{
				int newsize = piles[i].size() + piles[i-3].size();
				if(newsize > largest)
				{
					largest = newsize; 
					index_largest = i; 
					is_adj = false;
				}
			}
		}
		if(!movemade) //lose
			break;

		// apply move
		
		if(is_adj)
		{
			int i = index_largest; 
			piles[i-1].insert(piles[i-1].end(),piles[i].begin(),piles[i].end());
			piles.erase(piles.begin()+i); 
		}
		else
		{
			int i = index_largest;
			piles[i-3].insert(piles[i-3].end(),piles[i].begin(),piles[i].end());
			piles.erase(piles.begin()+i); 
		}
	}
	cout << piles.size() << " " << piles[0].back() << "\n";
	piles = ogpiles;

	// strat 3 (largest available moves)
	while(true)
	{
		if(piles.size() == 1) break;
		

		int most = -1;
		int index_most = -1;
		int is_adj = false; 
		int movemade = false;
		for(int i = piles.size()-1; i >= 1; i--)
		{
			if(valid(i-1,i) or valid(i-3,i)) movemade = true;

			if(valid(i-1,i))
			{
				vector<vector<string>> tmp_piles = piles;
				tmp_piles[i-1].insert(tmp_piles[i-1].end(),tmp_piles[i].begin(),tmp_piles[i].end());
				tmp_piles.erase(tmp_piles.begin()+i); 
				int cnt = n_valid(tmp_piles);
				if(cnt > most)
				{
					most = cnt;
					index_most = i;
					is_adj = true;
				}
			}
			if(valid(i-3,i))
			{
				vector<vector<string>> tmp_piles = piles;
				tmp_piles[i-3].insert(tmp_piles[i-3].end(),tmp_piles[i].begin(),tmp_piles[i].end());
				tmp_piles.erase(tmp_piles.begin()+i); 
				int cnt = n_valid(tmp_piles);
				if(cnt > most)
				{
					most = cnt;
					index_most = i;
					is_adj = false;
				}
			}
		}
			if(!movemade) break;
		
			if(is_adj)
			{
				int i = index_most; 
				piles[i-1].insert(piles[i-1].end(),piles[i].begin(),piles[i].end());
				piles.erase(piles.begin()+i); 
			}
			else
			{
				int i = index_most;
				piles[i-3].insert(piles[i-3].end(),piles[i].begin(),piles[i].end());
				piles.erase(piles.begin()+i); 
			
			}

	}
	cout << piles.size() << " " << piles[0].back() << "\n";
}
```