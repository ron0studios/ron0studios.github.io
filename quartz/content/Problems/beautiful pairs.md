# beautiful pairs
---
>[!summary] A hackerrank problem where I misread the question 🤦‍♂


# Explanation
---
This is a trivial [[Greedy]] problem if taken from the right approach.

Essentially, since you can **only make 1 operation** on the second list, there are only 2 outcomes. Either you increase the number of disjoint pairs by 1, or you decrease it by 1.

The only scenario where you decrease the number of disjoint pairs by 1 is when 

# Code
---
```cpp
int beautifulPairs(vector<int> A, vector<int> B) 
{
	// first find the beautiful set
	vector<pair<int,int>> bset;

	unordered_map<int,bool> vis;
	for(int i = 0; i < A.size(); i++)
	{
		for(int j = 0; j < A.size(); j++)
		{
			if(A[i] == B[j] and !vis.count(j)){
				bset.pb(mp(i,j));
				vis[j] = true;
				break;
			}
		}
	}
	//cout << bset.size();

	return (bset.size() == A.size()) ? bset.size() - 1 : bset.size() + 1;
}
```