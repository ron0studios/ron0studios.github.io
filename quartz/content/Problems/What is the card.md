# What is the card?
---
>[!summary] UVA 10646. Pretty simple implementation problem, just have to read the question **carefully** (took ~ 30 mins to 1 hour...)


# Explanation
---
This is a relatively simple [[ad hoc]] problem, which requires you to do a bit of array shuffling. This may be similar to [[Accordion patience]] or [[shuffling]], though *significantly* easier.
# Code
---
```cpp
int convert(char x){
	if(isalpha(x)){
		return 10;
	}
	else return x-'0';
}

void solve(int tc)
{
	vector<string> deck(52);
	int y = 0;
	for(int i = 0; i < 52; i++) {
		cin >> deck[i];
	}
	vector<string> top25 = vector<string>(deck.begin(), deck.begin()+27);
	
	for(int i = 0; i < 3; i++)
	{
		int val = convert(top25.back()[0]);
		y += val;
		top25.pop_back();
		for(int j = 0; j < 10-val; j++)
		{
			top25.pop_back();
		}
	}
	deck = vector<string>(deck.end()-25, deck.end());
	deck.insert(deck.begin(), top25.begin(), top25.end());

	cout << "Case " << tc << ": " << deck[y-1] << endl;
}
```