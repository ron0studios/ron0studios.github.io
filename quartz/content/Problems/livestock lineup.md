# livestock lineup
---
>[!summary] usaco 2019 december bronze


# Explanation
---
This is a [[complete search#Generating permutations|complete search problem involving permutations]]. Since there are only 8 cows, there are only $8!=40320$ permutations ([[combinatorics]]) to search through. This can be done using the `next_permuation` function in c++. We then check adjacencies for each permutation. 
Some [[string|string manipulation]] is needed.
# Code
---
```cpp
unordered_map<string,int> names = { {"Beatrice",0},
									{"Belinda",1},
									{"Bella",2},
									{"Bessie",3},
									{"Betsy",4},
									{"Blue",5},
									{"Buttercup",6},
									{"Sue",7}};


void solve()
{
	freopen("lineup.in","r",stdin);
	freopen("lineup.out","w",stdout);
	int n; cin >> n;
	unordered_map<int,vector<int>> rules;
	for(int i = 0; i < n; i++)
	{
		string a; cin >> a;
		for(int j = 0; j < 4; j++){
			string tmp; cin >> tmp;
		}
		string b; cin >> b; 
		rules[names[a]].pb( names[b] );
		rules[names[b]].pb( names[a] );
	}


	string perm = "01234567";
	string out = "";
	do{
		//cout << perm << endl;
		bool broke = false;
		for(int i = 0; i < 8; i++)
		{
			if(i==0)
			{
				int right = perm[i+1]-'0';
				if(rules[perm[i]-'0'].size() > 1) broke = true;
				if(rules[perm[i]-'0'].size()==0) continue;
				if(rules[perm[i]-'0'][0] != right) broke = true;
			}
			else if(i==7)
			{
				int left = perm[i-1]-'0';
				if(rules[perm[i]-'0'].size() > 1) broke = true;
				if(rules[perm[i]-'0'].size()==0) continue;
				if(rules[perm[i]-'0'][0] != left) broke = true;
			}
			else
			{
				int left  = perm[i-1]-'0';
				int right = perm[i+1]-'0';
				vector<int> rule = rules[perm[i]-'0'];
				for(auto j : rule)
				{
					if(j != left and j != right){
						broke = true; break;
					}
				}
			}
			if(broke) break;
		}
		if(!broke)
		{
			out = perm;
			break;
		}
	}
	while(next_permutation(perm.begin(),perm.end()));

	unordered_map<int,string> rev;
	for(auto i : names)
		rev[i.second] = i.first;


	for(auto i : out)
	{
		cout << rev[i-'0'] << "\n";
	}

}


```