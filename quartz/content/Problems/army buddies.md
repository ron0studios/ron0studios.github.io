# army buddies
---
>[!summary] UVA 12356. An interesting [[Linked list]] problem. Took around 1hr 45m


# Explanation
---
This is a problem that can be tackled in many ways, some easier than others.

### method 1
For example, you can simply create a boolean array, and set deleted values from the query to 0. We could then linearly probe values to find the first positive value to set as the neighbouring army buddy. However, this method is extremely slow, and will run on average for 18 seconds PER test case (worst case scenario).

### method 2
Another method, also too slow, would be to create a vector of incrementing values, e.g. (1,2,3,4,5 ...., N), and just use the `vector.erase(iter1, iter2)` function to *literally* delete the queries provided to us. This is actually much faster because the inbuilt c++ delete function is simply reallocating memory and shifting pointers instead of doing a linear scan to delete items like we are. Since we are using a dynamic vector, we also don't have to do the linear scan to find the neighbouring buddies. However, this method is still **just** shy of a valid solution, since it runs on average 1 second per test case (worst case scenario).

### method 3 (correct)
The actual correct answer would be to create a [[Linked list|Doubly linked list]], where each element holds a pointer to the element before and after it. We will internally store the list as a static array^[a vector for me because its easier to work with].  The value of the element will just be its index. When we delete an element, we point the element that comes before the `L` query to the element that comes after the `R` query and vice versa. *Note that we find the element that comes after or before the query element by using its left/right pointers instead of just decrementing or incrementing from its in-array position*.

# Code
---
```cpp

// METHOD 1: REGULAR ARRAY (18 seconds)
/*
void solve(int s, int b)
{
	vector<int> ppl(s,1);
	while(b--){
		int x,y;
		int outx, outy;
		outx = outy = -1;
		cin >> x >> y;
		for(int i = x-1; i < y; i++){
			ppl[i] = 0;
		}

		x--; y--;
		if(x-1 >= 0){
			x--;
			while(x >= 0 and ppl[x] == 0){
				x--;
			}
			outx = x;
		}
		if(y+1 < s){
			y++;
			while(y < s and ppl[y] == 0){
				y++;
			}
			outy = y;
			if(outy >= s) outy=-1;
		}

		outx++; outy++;
		cout << ( ( outx==0 ) ? "*" : to_string(outx) )<< " ";
		cout << ( ( outy==0 ) ? "*" : to_string(outy) )<< "\n";
	}
	cout << "-" << endl;
}
*/

// METHOD 2: DELETING FROM VECTOR (1 second)
/*
void solve(int s, int b)
{
	vector<int> ppl(s,1);
	ppl.reserve(s);
	iota(ppl.begin(), ppl.end(), 1);
	while(b--){
		int x,y;
		cin >> x >> y;


		auto l = lower_bound(ppl.begin(), ppl.end(), x);
		auto r = lower_bound(ppl.begin(), ppl.end(), y)+1;

		if(l==ppl.begin()){
			cout << "* ";
		}
		else{
			cout << *(l-1) << " ";
		}

		if(r == ppl.end()) {
			cout << "*" << "\n";
		}
		else {
			cout << *r << "\n";
		}

		ppl.erase(l,r);
	}
	cout << "-" << endl;

}
*/

// METHOD 3 (correct): DOUBLY LINKED LIST (0.1 seconds)
void solve(int s, int b)
{
	vector<pair<int,int>> ppl(s,mp(-1,1));
	for(int i = 1; i < s; i++)
		ppl[i] = mp(ppl[i-1].first+1, ppl[i-1].second+1);
	ppl.back().second = -1;
	while(b--){
		int x,y;
		int outx, outy;
		outx = outy = -1;
		cin >> x >> y;
		x--; y--;
		if(ppl[x].first>=0){
			ppl[ppl[x].first].second = ppl[y].second;
			outx = ppl[x].first;
		}
		if(ppl[y].second>=0){
			ppl[ppl[y].second].first = ppl[x].first;
			outy = ppl[y].second;
		}

		outx++; outy++;

		cout << ( ( outx==0 ) ? "*" : to_string(outx) )<< " ";
		cout << ( ( outy==0 ) ? "*" : to_string(outy) )<< "\n";
	}
	cout << "-" << endl;
}
```