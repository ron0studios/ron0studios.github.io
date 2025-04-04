# greedy florist
---
>[!summary] A good Hackerrank problem


# Explanation
---
This is a [[Greedy]] problem. 
Essentially, you have to first allocate all the most expensive flowers as early as possible since they multiply to much larger numbers than the cheaper flowers. Here is a way of going about this
- First [[sorting|sort]] and allocate the $k$ most expensive flowers to each of the friends. 
- In any order of friends, allocate each friend another flower if there are still remaining flowers. **Make sure to allocate the most expensive flowers first**.  All friends should have the same number of flowers by the end of this step^[unless all the flowers already ran out!]
- Repeat the process until there are no more flowers left.

# Code
---
```cpp
int getMinimumCost(int k, vector<int> c) {
	sort(c.begin(),c.end());
	deque<vector<int>> fr;
	for(int i = 0; i < k; i++)
	{
		if(c.empty()) break;
		int a = c.back();
		c.pop_back();
		fr.push_front({a});
	}

	while(!c.empty())
	{
		fr[0].pb(c.back());
		fr.push_back(fr.front());
		fr.pop_front();
		c.pop_back();
	}

	// calc score
	int score = 0;
	for(int i = 0; i < fr.size(); i++)
	{
		for(int j = 0; j < fr[i].size(); j++)
		{
			score += (1+j)*fr[i][j];
		}
	}

	for(auto i : fr)
	{
		for(auto j : i)
			cout << j << " ";
		cout << endl;
	}
	cout << "score: " << score << endl;
    return score;
}
```