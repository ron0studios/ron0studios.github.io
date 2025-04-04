# inception
---
>[!summary] UVA 13055. Easy [[stack]] problem. Took 5 mins 💀


# Explanation
---
Simply simulate the *inception* by incrementing and decrementing names from a [[stack]]. Make sure to include a check for the `kick` query, since the problem still expects you to perform a kick even if the stack is empty.
# Code
---
```cpp
void solve()
{
	int q; cin >> q;
	vector<string> stack;
	while(q--){
		string query; cin >> query;
		if(query == "Sleep"){
			string person; cin >> person;
			stack.pb(person);
		} else if(query == "Kick"){
			if(!stack.empty()) stack.pop_back();
		} else if(query == "Test"){
			if(stack.empty()){
				cout << "Not in a dream" << endl;
			} else {
				cout << stack.back() << endl;
			}
		}
	}
}
```