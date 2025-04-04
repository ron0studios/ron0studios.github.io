# rational grading
---
>[!summary] UVA 13151. An interesting [[ad hoc]] problem that has quite a few edge cases that I forgot to account for (too silly to notice). Took around 45 minutes


# Explanation
---
This problem requires you firstly to understand what the difference between `i++` and `++i` is. If the increment operator precedes the `i` variable then the return value of the statement will be the variable **after** it has been incremented. If the operator proceeds the variable then the return value will be the variable **before** it has been incremented. 

Therefore, we will need to consider each case of the operators separately, maintaining a variable `n` that will initially follow the correct output, but then adapt to the users input and follow that instead if the user input deviates from the correct one.
# Code
---
```cpp
void solve(string init, int tc)
{
	int ival = 0;
	int score = 0;
	if(init.size() > 2 and init.substr(0,2) == "0x"){
		string s = string(init.begin()+2, init.end());
		reverse(s.begin(), s.end());
		for(int i = 0; i < s.size(); i++) {
			int val;
			if(isdigit(s[i]))
				val = s[i]-'0';
			else
				val = s[i]-'A'+10;
			ival += pow(16,i)*(val);
		}
	}
	else if(init[0] == '0'){
		string s = init;
		reverse(s.begin(),s.end());
		for(int i = 0; i < s.size(); i++) {
			ival += pow(8,i)*(s[i]-'0');
		}
	}
	else{
		ival = stoi(init);
	}

	int n = ival;
	for(int i = 0; i < tc; i++){
		string op; cin >> op;
		int expected;

		if(op == "i++"){
			expected = n;
			n++;
		}
		else if(op == "i--"){
			expected = n;
			n--;
		}
		else if(op == "++i"){
			n++;
			expected = n;
		}
		else if(op=="--i"){
			n--;
			expected = n;
		}
		else{
			expected = n;
		}


		int output; cin >> output;

		if(output == expected){
			score++;
		}
		else
		{
			if(op == "i++"){
				n = output+1;
			}
			else if(op == "i--"){
				n = output-1;
			}
			else{
				n = output;
			}
		}
	}
	
	cout << score << endl;
}
```