# traditional BINGO
---
>[!summary] UVA 10813. A medium [[ad hoc]] games problem. took around 45 minutes.


# Explanation
---
This problem is reminiscent of a BIO question 2, and can be treated similarly by using a similar approach to tackling those styles of problems. 
We can create a [[matrix|grid]] of all the card values, and do a simple search for all the matching bingo cell for a certain called number, if it exists. 
This problem uses a delta method exactly like [[four in a line]] except we're trying a 5 in a line for bingo lines.
# Code
---
```cpp

bool ok(vector<int> x){
	return x[0] >= 0 and x[1] >= 0 and x[0] < 5 and x[1] < 5;
}

void solve(int tc)
{
	vector<vector<int>> card(5,vector<int>(5,0));
	vector<vector<bool>> checks(5,vector<bool>(5,false));
	checks[2][2] = true;
	vector<vector<vector<int>>> delta = {
		{{0,0},{1,0},{2,0},{3,0},{4,0}},
		{{0,0},{-1,0},{-2,0},{-3,0},{-4,0}},
		{{0,0},{0,1},{0,2},{0,3},{0,4}},
		{{0,0},{0,-1},{0,-2},{0,-3},{0,-4}},
		{{0,0},{1,1},{2,2},{3,3},{4,4}},
		{{0,0},{-1,-1},{-2,-2},{-3,-3},{-4,-4}},
		{{0,0},{1,-1},{2,-2},{3,-3},{4,-4}},
		{{0,0},{-1,1},{-2,2},{-3,3},{-4,4}}
	};

	for(int i = 0; i < 5; i++){
		for(int j = 0; j < ((i==2) ? 4 : 5); j++){
			cin >> card[i][j];
		}
	}
	swap(card[2][4], card[2][3]);
	swap(card[2][3], card[2][2]);

	vector<int> callouts(75);
	for(int i =0 ; i < 75; i++){
		cin >> callouts[i];
	}

	for(int i = 0; i < 75; i++){
		int num = callouts[i];
		for(int j = 0; j < 5; j++){
			int search = find(card[j].begin(), card[j].end(), num)-card[j].begin();
			if(search == 5) continue;
			checks[j][search] = true;
			break;
		}
		

		for(int j = 0; j < 5; j++){
			for(int k = 0; k < 5; k++){
				for(int l = 0; l < 8; l++)
				{
					bool streak = true;
					for(int m = 4; m >= 0; m--){
						vector<int> coord = {delta[l][m][0]+j, delta[l][m][1]+k};
						if(!ok(coord) or !checks[coord[0]][coord[1]]){
							streak = false;
							break;
						}
					}
					if(streak) { 
						cout << "BINGO after " << i+1 << " numbers announced" << endl;
						return;
					}
				}
			}
		}
	}

}
```