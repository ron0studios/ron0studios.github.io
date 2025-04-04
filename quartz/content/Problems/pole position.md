# pole position
---
>[!summary] UVA 12150. Very easy [[ad hoc]] problem. took around 15 mins


# Explanation
---
Somewhat reminiscent of an [[inverse prefix sum]] in that the positions are deltas of where they should be. Regardless, besides the couple presentation hiccoughs, all you need to do is create an auxiliary array that maintains the original positions of all the cars. If any of these positions find themselves outside the bounds of the race positions, e.g. negative or too high, then we return `-1`.
# Code
---
```cpp
void solve(int cars)
{
	vector<int> carpos(cars);
	vector<int> rel(cars);
	for(int i = 0; i < cars; i++){
		cin >> carpos[i] >> rel[i];
	}

	vector<int> out(cars, -1);

	for(int i = 0; i < cars; i++){
		int newpos = i+ rel[i];
		if(newpos < 0 or newpos >= cars) {
			cout << -1 << endl;
			return;
		}
		if(out[newpos] != -1){
			cout << -1 << endl;
			return;
		}

		out[newpos] = carpos[i];
	}

	for(int i = 0; i < cars-1; i++){
		cout << out[i] << " ";
	}
	cout << out.back();
	cout << endl;
}
```