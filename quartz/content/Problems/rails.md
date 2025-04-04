# rails
---
>[!summary] UVA 514. Pretty easy [[stack]] problem, with annoying input format. Took 20 mins


# Explanation
---
Just need to simulate the problem using an actual [[stack]] and see if the target sequence is reproducible or not, in a somewhat [[Greedy]] fashion. No optimisation is needed for this problem.
# Code
---
```cpp
void solve(int n)
{
	cin.ignore();
	while(true){
		string raw; getline(cin, raw);
		if(raw=="0") break;
		stringstream ss(raw);
		vector<int> trains(n);
		for(int i = 0; i < n; i++){
			ss >> trains[i];
		}
		vector<int> stack;
		int ptr =0;
		for(int i = 1; i <= n+1; i++){
			while(stack.size() and stack.back()==trains[ptr]){
				ptr++;
				stack.pop_back();
			}
			if(i<n+1) stack.pb(i);
		}

		if(ptr==n){
			cout << "Yes";
		}
		else {
			cout << "No";
		}
		cout << endl;
	}
	cout << endl;
}
```