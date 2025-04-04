# containers
---
>[!summary] UVA 1062. Fun [[stack]] problem. Took around 15 mins


# Explanation
---
We take a [[Greedy]] approach for this problem, incrementing through each element in the shipping order, and adding elements to a stack. If the current element of the shipping order is greater than any of the top elements in any of our stacks, we create a new stack with this element as the top element.
When choosing between multiple stacks to put our current element, we choose the stack top which is the closest to the current element.
# Code
---
```cpp
void solve(int tc, string s)
{
	vector<string> stacks = {string(1,s[0])};
	for(int i = 0; i < s.size(); i++){
		int mx = INT_MIN;
		int idx = -1;
		for(int j = 0; j < stacks.size(); j++){
			if(s[i]-stacks[j].back() > 0) continue;
			if(s[i]-stacks[j].back() > mx){
				mx = s[i]-stacks[j].back();
				idx = j;
			}
		}
		if(idx == -1){
			stacks.pb(string(1,s[i]));
		} else {
			stacks[idx] += s[i];
		}
	}

	cout << "Case " << tc<< ": " << stacks.size() << endl;
}
```