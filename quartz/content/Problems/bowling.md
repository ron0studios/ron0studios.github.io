# bowling
---
>[!summary] UVA 584. Quite a simple [[ad hoc]] problem, took around 30 minutes


# Explanation
---
This problem requires quite a lot of reading, especially with the unholy waffle about the history of bowling in the first section of the statement 😭.

All you need to do is watch out for which frame number you are on, for example by maintaining a `curframe` pointer. You may also find it useful to tokenise the input by using a `stringstream` which allows you to deal with strings the same way you can use the IO functions for `stdin` or `stdout`.
# Code
---
```cpp
void solve(string game)
{
	vector<int> tokens; // -1 is spare -2 is strike
	vector<vector<int>> framescores;
	int score = 0;
	stringstream ss(game);
	char token;
	while(ss >> token){
		if(isdigit(token)){
			tokens.pb(token - '0');
		}
		else if(token == '/'){
			tokens.pb(-1);
		}
		else{
			tokens.pb(-2);
		}
	}

	int curframe = 1;
	while(!tokens.empty()){
		
		/*cout << score << " : " << curframe << endl;
		for(auto i : tokens){
			cout << i << " ";
		}
		cout << endl;*/
		
		int one = tokens[0]; 
		tokens.erase(tokens.begin());
		int two;
		if(one != -2) {
			two = tokens[0];
			tokens.erase(tokens.begin());
			if(two == -1){
				score += 10;
				if(tokens[0] == -2){
					score += 10;
				}else score += tokens[0];
				if(curframe ==10) break;
			}
			else{
				score += one + two;
			}

		}
		else {
			score += 10;
			if(tokens[0] == -2){
				score += 10;
				if(tokens.size() > 1 and tokens[1] == -2){
					score += 10; 
				} else {
					score += tokens[1];
				}
			}else if(tokens[1] == -1){
				score += 10;
			}
			else{
				score += tokens[0] + tokens[1];
			}
			if(curframe == 10) break;
		}
		curframe ++;
	}


	cout << score << endl;


}
```