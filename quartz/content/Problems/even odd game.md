# even odd game
---
>[!summary] Good codeforces problem


# Explanation
---
This is a [[Algorithms/game theory]] problem. 

Let's begin by rephrasing the problem in terms of $x$. Imagine player A (Alice) trying to maximise some value $x$, whilst player B (Bob) is trying to minimise $x$. Let us also imagine that when player A gains points it increases $x$ by $a_i$, only if $a_{i}=2k, k\in \mathbb{N}$. Similarly, when player B gains points it decreases $x$ by $a_i$ only if $a_{i}=2k+1,k\in\mathbb{N}$. 

When player A makes a move, it picks an item from the list, say $a_i$:
- if $a_i$ is odd, player A may not gain any points, but player B loses the opportunity to gain those points
- if $a_i$ is even, player A gains those points, and player B doesn't gain anything

From this, we conclude that picking an item is better than not picking it. And therefore, to maximise A's result, it must pick the largest item in the list [[Greedy|greedily]]. 

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];

	sort(a.begin(), a.end());

	long long ascore = 0;
	long long bscore = 0;

	int turn = 1;
	while(a.size())
	{
		turn = !turn;
		int item = a.back(); a.pop_back();
		if(turn)
		{
			bscore += ( (item) % 2) * item;
		} 
		else
		{
			ascore += ( (item+1) % 2) * item;
		}
	}

	if(ascore == bscore) cout << "Tie\n";
	if(ascore >  bscore) cout << "Alice\n";
	if(ascore <  bscore) cout << "Bob\n";
}
```