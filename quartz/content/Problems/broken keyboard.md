# broken keyboard
---
>[!summary] UVA 11988. A simple [[Linked list]] problem. Took around 10 mins


# Explanation
---
This problem requires you to either use a [[Linked list]] or a fast double-ended structure like `deque`, although the internal structure of the problem is still essentially a linked list. When the `home` key is pressed, a new node must be added to the beginning of the linked list and new insertions of characters must be done from that element. The same goes vice versa for the `end` key. When printing we can just loop through the linked list and print the strings sequentially. 
# Code
---
```cpp
void solve(string s)
{
	deque<string> out = {""};
	stringstream ss(s);
	char inp;
	bool mode = 1;
	while(ss >> inp){
		if(inp=='['){
			out.push_front("");
			mode = 0;
		}
		else if(inp==']'){
			out.push_back("");
			mode = 1;
		}
		else {
			if(mode){
				out.back() += inp;
			} else {
				out.front() += inp;
			}
		}
	}
	for(auto &i: out){
		cout << i;
	}
	cout << endl;
}
```