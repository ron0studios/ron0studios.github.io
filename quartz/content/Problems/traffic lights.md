# traffic lights
---
>[!summary] UVA 161. This is a relatively okay [[ad hoc]] problem. Took around 45-50mins


# Explanation
---
This problem can be [[Brute force|brute forced]] pretty easily. Whilst it looks like there is a lot of modular arithmetic required for this problem, it is only really necessary for displaying the time value at the end. The simplest way to solve this problem is just by simulating the traffic light states up to the 5 hour mark for every traffic light and finding a point where they are all green. 
This, in fact, **does** run within the time constraints of the problem.
# Code
---
```cpp
void solve(vector<int> inp)
{
	vector<vector<int>> cycles(inp.size(), vector<int>());
	int mincycle = INT_MAX;
	for(int i = 0; i < inp.size(); i++){
		mincycle = min(mincycle, inp[i]);
		vector<int> green(inp[i]-5, 0);
		vector<int> orange(5, 1);
		vector<int> red(inp[i], 2);
		for(int j = 0; j < 901; j++) {
			if(cycles[i].size() > 18000) break;
			cycles[i].insert(cycles[i].end(), green.begin(), green.end());
			cycles[i].insert(cycles[i].end(), orange.begin(), orange.end());
			cycles[i].insert(cycles[i].end(), red.begin(), red.end());
		}
	}

	int start = mincycle-5;
	for(int i = start; i <= 18000; i++){
		bool matching = true;
		for(int j = 0; j < cycles.size(); j++){
			if(cycles[j][i] != 0){
				matching = false;
				break;
			}
		}
		if(matching){
			int hours, minutes, seconds;
			hours = i / 3600;
			minutes = (i%3600) / 60; 
			seconds = (i%60);
			cout << setfill('0') << setw(2) << hours;
			cout << ":";
			cout << setfill('0') << setw(2) << minutes;
			cout << ":";
			cout << setfill('0') << setw(2) << seconds;
			cout << endl;
			return;
		}
	}
	cout << "Signals fail to synchronise in 5 hours" << endl;

}
```