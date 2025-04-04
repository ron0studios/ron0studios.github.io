---
aliases:
  - infix to postfix
---

# Shunting Yard Algorithm
---
>[!summary] An algorithm created by Edsger W. Dijkstra to [[parsing|parse]] human readable Infix expressions into a more easily processable reverse polish notation^[postfix notation]


# Explanation
---
The algorithm maintains a [[queue]] for the incoming stream of characters to convert. It also maintains a [[stack]] of operators, that will be used while the algorithm is running to reintroduce the operators at the end of a certain scope in the expression, in order of precedence. 
The pseudocode of the algorithm is as follows:
```pseudocode
While there are tokens to be read:
      Read a token
      If it's a number add it to queue
      If it's an operator
             While there's an operator on the top of the stack with greater precedence:
                     Pop operators from the stack onto the output queue
             Push the current operator onto the stack
      If it's a left bracket push it onto the stack
      If it's a right bracket 
           While there's not a left bracket at the top of the stack:
                    Pop operators from the stack onto the output queue.
            Pop the left bracket from the stack and discard it
While there are operators on the stack, pop them to the queue
```
# Code
---
```cpp
string infixToPostfix(string inputstring) {
    queue<char> stream;
	string output;
	char inpc;
	stringstream ss(inputstring);
	while(ss >> inpc) {
		stream.push(inpc);
	}


	unordered_map<char, int> precedence;
	precedence['('] = -1;
	precedence[')'] = -1;
	precedence['+'] = 0;
	precedence['-'] = 0;
	precedence['*'] = 1;
	precedence['/'] = 1;
	precedence['^'] = 2;
	stack<char> s;
	while(!stream.empty()) {
		char front = stream.front(); stream.pop();
		
		if(isdigit(front) or isalpha(front)){
			output += front;
			continue;
		}

		if(front == ')'){
			while(s.top() != '('){
				char top = s.top(); s.pop();
				output += top;
			}
			s.pop();
		}
		else if(front=='('){
			s.push(front);
		}
		else {
			while(!s.empty() and precedence[s.top()] >= precedence[front]){
				output += s.top(); s.pop();
			}
			s.push(front);
		}
	}

	while(!s.empty()){
		output += s.top();
		s.pop();
	}


	return output;

    }
```
