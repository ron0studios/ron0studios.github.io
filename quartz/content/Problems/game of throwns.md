# game of throwns
---
>[!summary] kattis-throwns. A fun [[stack]] problem. Took around 20 mins.


# Explanation
---
This problem is essentially a simulation of the game that is being played in the problem statement. Make sure to handle the `stringstream` correctly with `cin.ignore()` and be careful with negative modulo.

> [!warning] True modulo
> In python modulo works as you would expect it to, but c/c++ uses pure remainder modulo, meaning that most modulo operations dont work as intended when the operands are negative. To fix this we can convert a c modulo into a python modulo as follows: $$((x\%M)+M)\%M$$
# Code
---
```cpp
void solve()
{
	int n, k; cin >> n >> k; cin.ignore();
	vector<int> stack = {0};

	string raw; getline(cin, raw); 
	stringstream ss(raw);
	string instr;
	while(ss >> instr){
		if(instr == "undo"){
			int amt; ss >> amt;
			while(amt--){
				if(stack.empty()) break;
				stack.pop_back();
			}
		}
		else {
			int dx = stoi(instr);
			int pos = stack.back();
			pos += dx;
			if(pos >= n){
				pos %= n;
			} else if(pos < 0){
				pos = ((pos%n)+n)%n;
			}
			stack.pb(pos);
		}
	}
	
	cout << (stack.empty() ? 0 : stack.back()) << endl;
}
```