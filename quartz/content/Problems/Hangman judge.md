# Hangman judge
---
>[!summary] UVA 00489. Relatively simple [[ad hoc]] problem. Was my first time in a while writing the whole solution and getting the code to compile and pass all the tests first try!! 🥳 Took around 10 minutes


# Explanation
---
This problem requires you to first figure out how many correct guesses you need to get the hangman word correct. In other words we need to figure out how many unique characters there are in the [[string]]. A simple way of doing this is by creating an `std::set` structure based on the iterators of the solution string, and simply returning the size of the string. This may not be the most efficient way of solving this issue, but the constraints give us the freedom to do so.
Next we need to loop through all the guess characters that the user has given. While we loop through these guesses we maintain a `used` [[hash map]], that keeps a track of which characters we have guessed already so that we dont end up double scoring or penalising guessing the same character twice. 
Lastly we just conduct some simple logic to figure out which outcome we get from this game. 
- If we failed 7 times or more, then we will have lost the game.
- if we have gotten as many correct guesses as there are unique characters in the solution, then we have won the game.
- if neither of these are applicable then we have chickened out.
# Code
---
```cpp
void solve(int tc)
{
	cout << "Round " << tc << endl;
	string sol, guess; 
	cin >> sol >> guess;

	int uniquechars = set<char>(begin(sol), end(sol)).size();

	unordered_map<char,bool> used;
	int fails = 0;
	int succs = 0;
	for(int i = 0; i < (int)guess.size(); i++)
	{
		if(fails == 7 or succs == uniquechars){
			break;
		}
		char cur = guess[i];
		if(used.count(cur)) continue;
		if(sol.find(cur) == string::npos) {
			fails++;
		}
		else {
			succs++;
		}
		used[cur] = true;
	}

	if(fails == 7)
	{
		cout << "You lose." << endl;
	}
	else if(succs == uniquechars)
	{
		cout << "You win." << endl;
	}
	else {
		cout << "You chickened out." << endl;
	}
}
```