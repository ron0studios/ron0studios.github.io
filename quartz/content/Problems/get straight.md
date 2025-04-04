# get straight
---
>[!summary] UVA 11013. A harder [[ad hoc]] cards problem, similar to [[Cards exchange]]. took around 1 day


# Explanation
---
This problem seems like it may require some kind of dp technique or whatnot to fit within the time limit, however it can be done by simply using [[Brute force]]. 
What we can do is find the [[Probability#Expected value|Expected value]] after removing each card from the hand and replacing it from all the other possible cards in the deck. The *maximum* possible expected value that also happens to exceed both the current value of the *original hand* and the cost of playing the game, which was *one* dollar, will be the best card to swap. 
If no such card actually improves upon the value of the current hand, then we conclude that the best possible option is to `Stay`.
# Code
---
```cpp

int specificval(vector<int> deck) {
	vector<int> streaks={1};
	for(int i = 1; i < 5; i++)
	{
		if(deck[i] == deck[i-1]+1 or (deck[i] == 1 and deck[i-1] == 13)){
			streaks.back()++;
		}else{
			streaks.pb(1);
		}
	}
	vector<int> out;
	for(auto i : streaks)
		if(i>1) out.pb(i);

	sort(out.begin(),out.end());

	if(!out.size()) return 0;
	if(out.size() == 1){
		switch(out[0]){
			case 5:
				return 100;
			case 4:
				return 10;
			case 3:
				return 3;
			case 2:
				return 0;
		}
	}
	else if(out.size() == 2){
		switch(out[1]){
			case 3:
				return 5;
			case 2:
				return 1;
		}
	}
	cout << "HUH"; 
	return 0;
}

int getvalue(vector<int> hand){
	sort(hand.begin(), hand.end());
	int maxval = specificval(hand);
	while(next_permutation(hand.begin(), hand.end())){
		maxval = max(maxval, specificval(hand));
	}
	return maxval;
}



void solve(string s)
{
	vector<string> tokens;
	stringstream ss(s);
	string token;
	while(ss >> token){
		tokens.pb(token);
	}

	unordered_map<int,int> deck;
	for(int i = 1; i <= 13; i++)
		deck[i] = 4;

	vector<int> hand;
	for(auto i : tokens){
		if(isdigit(i[0])) hand.pb(i[0]-'0');
		else{
			switch(i[0]){
				case 'A':
					hand.pb(1);
					break;
				case 'T':
					hand.pb(10);
					break;
				case 'J':
					hand.pb(11);
					break;
				case 'Q':
					hand.pb(12);
					break;
				case 'K':
					hand.pb(13);
					break;
			}
		}

		deck[hand.back()]--;
	}

	int initialvalue = getvalue(hand);
	float maxbet = 0;
	int maxcard = -1;
	
	for(int j = 0; j < 5; j++)
	{
		float expectedvalue = 0;
		int five = 0;
		int four = 0;
		int threetwo = 0;
		int three = 0;
		int twotwo = 0;
		for(auto i : deck)
		{
			if(i.second == 0) continue;
			vector<int> handclone = hand;
			handclone[j] = i.first;
			int val = getvalue(handclone);

			switch(val){
				case 1:
					twotwo += i.second;
					break;
				case 3:
					three += i.second;
					break;
				case 5:
					threetwo += i.second;
					break;
				case 10:
					four += i.second;
					break;
				case 100:
					five += i.second;
					break;
			}
		}
		expectedvalue = five*100.0 + four*10.0 + threetwo*5.0 + three*3.0 + twotwo*1.0;
		expectedvalue /= 47.0;
		expectedvalue -= 1+initialvalue;
		/*
		cout << "CARD: " << tokens[j] << endl;
		cout << "1: " << twotwo << endl;
		cout << "3: " << three << endl;
		cout << "5: " << threetwo << endl;
		cout << "10: " << four << endl;
		cout << "100: " << five << endl;
		cout << "expected value: " << expectedvalue << endl << endl;
		*/

		if(expectedvalue > maxbet){
			maxcard = j;
			maxbet = expectedvalue;
		}
	}
	

	if(maxcard == -1){
		cout << "Stay\n";
	}
	else{
		cout << "Exchange " << tokens[maxcard] << "\n";
	}
}
```