# back and forth
---
>[!summary] A good problem that combines implementation and recursion


# Explanation
---
This is a relatively simple [[complete search#Recursively|recursive complete search]] problem but with a bit of a nitpicky implementation.

# Code
---
```cpp
vector<int> barnA;
vector<int> barnB;
unordered_map<int,bool> results;

void compute(int tankA, int tankB, int depth, vector<int> history = {})
{
	if(depth == 0)
	{
		results[tankA]=true;
		return;
	}


	if(depth % 2) //odd
	{
		vector<int> oldB = barnB;
		vector<int> hst=history;
		for(size_t i = 0; i < barnB.size(); i++)
		{
			barnA.pb(barnB[i]);
			barnB.erase(barnB.begin()+i);
			hst.pb(barnA.back());
			compute(tankA+barnA.back(), tankB - barnA.back(), depth-1, hst);
			hst.pop_back();
			barnA.pop_back();
			barnB = oldB;
		}
	}
	else // even
	{
		vector<int> oldA = barnA;
		vector<int> hst=history;
		for(size_t i = 0; i < barnA.size(); i++)
		{
			barnB.pb(barnA[i]);
			barnA.erase(barnA.begin()+i);
			hst.pb(barnA.back());
			compute(tankA-barnB.back(), tankB + barnB.back(), depth-1, hst);
			hst.pop_back();
			barnB.pop_back();
			barnA = oldA;
		}
	}
}

void solve()
{
	freopen("backforth.in","r",stdin);
	freopen("backforth.out","w",stdout);
	int tankA, tankB;
	barnA = barnB = vector<int>(10,0);
	tankA = tankB = 1000;
	results.clear();
	for(int i = 0; i < 10; i++)
		cin >> barnA[i];
	for(int i = 0; i < 10; i++)
		cin >> barnB[i];
	compute(tankA,tankB,4);
	cout << results.size();
}
```