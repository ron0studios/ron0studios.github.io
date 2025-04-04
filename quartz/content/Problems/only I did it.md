# only I did it
---
>[!summary] UVA 11222. A relatively simple arrays problem, made difficult with tedious edge cases, and misreading of the input. Took around 2 hours.


# Explanation
---
This is a mix of an arrays problem with some [[sorting]], when dealing with the implementations side. Please refer to my personal codebase to see the number of mistakes I made from misreading the input or general carelessness. 

Essentially what you have to do is simple looping through each of the 3 arrays for each friend, and see which elements are present in each array that aren't present in a *set union* of the two other arrays. 

After that point it is simply a case of sorting the array correctly, descending on the number of problems not present in the other two friends, but ascending on the friend number itself. I have implemented a custom comparator for this.
# Code
---
```cpp

void solve(int tc)
{
	vector<set<int>> problems(3);
	
	//im stupid i didnt read that the first element was 
	// the number of elements for a certain friend omds
	for(int i = 0; i < 3; i++){
		int n; cin >> n;
		for(int j = 0; j < n; j++){
			int x; cin >> x; 
			problems[i].insert(x);
		}
	}


	vector<vector<int>> scores(3,vector<int>({0,0}));
	for(int i = 0; i < 3; i++)
	{
		scores[i][1] = 2-i;
		set<int> others;
		others.insert(problems[(i+1)%3].begin(), problems[(i+1)%3].end());
		others.insert(problems[(i+2)%3].begin(), problems[(i+2)%3].end());

		for(auto j : problems[i]){
			if(!others.count(j)){
				scores[i][0]++;
				scores[i].pb(j);
			}
		}
	}

	sort(scores.begin(), scores.end(), [](const vector<int> &l, const vector<int> &r){
			if(l[0] != r[0]){
				return l[0] > r[0];
			}
			else{
				return l[1] > r[1];
			}
			});

	int i = 0;
	cout << "Case #" << tc << ":" << endl;
	while(i < scores.size() and scores[i][0] == scores[0][0]){
		cout << (2-scores[i][1])+1 << " " << scores[i][0];
		if(scores[i].size() > 2) cout << " ";
		for(int j = 2; j < scores[i].size(); j++){
			cout << scores[i][j];
			if(j < scores[i].size()-1)
				cout << " ";
		}
		cout << endl;
		i++;
	}
}
```