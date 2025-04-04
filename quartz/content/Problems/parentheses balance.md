# parentheses balance
---
>[!summary] UVA 673. Simple [[stack]] problem. Took around 7 mins


# Explanation
---
A very classic **parentheses matching** problem. Simply add open brackets to the stack and pop when encountering a close bracket. 
*make sure to read strings using `getline` and __not__ cin*.
# Code
---
```cpp
void solve(int tc)
{
	vector<int> stack; 
	string s; getline(cin, s);
	for(int i = 0; i < s.size(); i++){
		if(s[i] == '('){
			stack.pb(0);
		}
		if(s[i] == '['){
			stack.pb(1);
		}
		if(s[i] == ')'){
			if(stack.empty() or stack.back() != 0){
				cout << "No" << endl;
				return;
			} else {
				stack.pop_back();
			}
		}
		if(s[i] == ']'){
			if(stack.empty() or stack.back() != 1){
				cout << "No" << endl;
				return;
			} else {
				stack.pop_back();
			}
		}
	}
	if(stack.empty()) cout << "Yes" << endl;
	else cout << "No" << endl;
}
```