# Global raining at Bididibus
---
>[!summary] UVA 11786 problem. relatively simple in concept but can get overcomplicated very easily if you don't use the right technique (like me 🤦‍♂) (took ~3 hours spread over a day...)


# Explanation
---
The trick here is to use a [[stack]] data structure, and add to the stack of the position of any encountered downwards slope. If there is an upwards slope and matching downwards slope in the stack (i.e if the stack is not empty), then we can simply pop the position from the top of the stack and conclude that the space between the upwards and downwards slope as `curPosition - stack.top()`. 
# Code
---
```cpp
void solve(int tc){
	string s; cin >> s;
	int out = 0;
	stack<int> st;

	for(int i = 0; i < s.size(); i++)
	{
		if(s[i] == '\\'){
			st.push(i);
		}
		else if(s[i] == '/'){
			if(not st.size()) continue;
			int topop = st.top(); st.pop();
			out += i-topop;
		}
	}

	cout << out << endl;
}
```