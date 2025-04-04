# contest scoreboard
---
>[!summary] UVA 10258. A relatively simple problem that I over complicated with my garbage solution. Took around 1 hour


# Explanation
---
This is a standard [[sorting]] problem, with a couple kinks. The main issue is to not double count problems that have been solved twice, or incorrect submissions made after the problem was originally solved. To fix this, you can maintain an *index* of each user's submissions and whether they have solved a problem already. This is of course very memory inefficient, but luckily the constraints were only 10 problems and 100 contestants so it was feasible. 

The array format for `scores` is
$$\text{\{userSubmitted, problemsSolved, penaltyTime, playerNumber\}}$$
where `userSubmitted` is a boolean value to check whether that user has actually made a submission or not. This is so that we don't have to list **all** 100 contestants, even if not all of them necessarily participated in the contest.
# Code
---
```cpp
void solve(int tc)
{
	vector<vector<int>> scores(100, vector<int>(4));
	vector<vector<int>> solved(100, vector<int>(10));
	vector<vector<int>> incorrect(100, vector<int>(10));
	for(int i =0 ; i < 100; i++) scores[i][3] = -i-1;
	string tmp= "";
	while(getline(cin,tmp)){
		if(tmp.empty()) break;
		stringstream ss(tmp);
		int a,b,c; char x;
		ss >> a >> b >> c >> x;
		scores[a-1][0] = 1;
		if(solved[a-1][b-1]) continue;
		if(x == 'C'){
			scores[a-1][1]++;
			scores[a-1][2] -= c;
			scores[a-1][2] -= 20*incorrect[a-1][b-1];
			solved[a-1][b-1] = 1;
		}
		if(x== 'I'){
			incorrect[a-1][b-1]++;
		}
	}

	sort(scores.begin(), scores.end(), greater<vector<int>>());

	for(int i = 0; i < scores.size(); i++){
		if(!scores[i][0]) break;
		cout << -scores[i][3] <<  " " << scores[i][1] << " " << -scores[i][2]  << endl;
	}
	if(tc) cout << endl;
}
```