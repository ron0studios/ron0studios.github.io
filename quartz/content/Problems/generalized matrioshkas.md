# generalized matrioshkas
---
>[!summary] UVA 11111. An interesting [[stack]] problem. Took around 30 mins


# Explanation
---
This problem is a slight twist on the classic *parentheses-style* [[stack]] problems, similar to [[parentheses balance]].  However, this problem has the additional constraint of requiring all direct children of a matrioshka to be **strictly** smaller than the parent matrioshka. 
Since a matrioshka in this question can have more than one child, we need to maintain a second value for every element in the [[stack]] that accumulates each child of the matrioshka. 
# Code
---
```cpp
void solve(string s)
{
	stringstream ss(s);

	vector<pair<int,int>> stack;
	int item;
	while(ss >> item){
		if(item < 0){
			if(!stack.empty() and stack.back().first > item){
				cout << ":-( Try again." << endl;
				return;
			} else {
				stack.pb(mp(item,0));
			}
		} else {
			if(stack.empty() or stack.back().first != -item){
				cout << ":-( Try again." << endl;
				return;
			} else {
				if(!stack.empty()) stack.pop_back();
				if(!stack.empty()){
					stack.back().second += item;
					if(stack.back().second >= -stack.back().first){
						cout << ":-( Try again." << endl;
						return;
					}
				}
			}
		}
	}

	if(stack.empty()){
		cout << ":-) Matrioshka!" << endl;
	} else {
		cout << ":-( Try again." << endl;
	}

}
```