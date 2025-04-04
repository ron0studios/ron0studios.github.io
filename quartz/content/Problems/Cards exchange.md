# Cards exchange
---
>[!summary] UVA 11678. An easy problem where you just need to compare two sets (took ~ 10 minutes)


# Explanation
---
This requires [[hash map|set]] comparison between the two card collections that alice and betty have, finding the cards in alice's set that betty does not have and the cards in betty's set that alice doesn not have. The minimum of the two is the amount that can be traded between the both of them because both people have to give each other the same number of cards.
# Code
---
```cpp
void solve(int num_a, int num_b)
{
	std::set<int> cardsA, cardsB;
	for(int i =0 ; i < num_a; i++)
	{
		int tmp; cin >> tmp;
		cardsA.insert(tmp);
	}
	for(int i =0 ; i < num_b; i++)
	{
		int tmp; cin >> tmp;
		cardsB.insert(tmp);
	}

	// how many A can give to B
	int Atrade = 0;
	for(auto i : cardsA)
	{
		if(!cardsB.count(i)){
			Atrade++;
		}
	}

	
	// how many B can give to A
	int Btrade = 0;
	for(auto i : cardsB)
	{
		if(!cardsA.count(i)){
			Btrade++;
		}
	}

	cout << min(Atrade, Btrade) << endl;

}
```