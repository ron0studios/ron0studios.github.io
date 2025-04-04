# booklet printing
---
>[!summary] UVA 637. An ordering [[ad hoc]] problem. took around 30 to 35 minutes.


# Explanation
---
This problem involves picturing the ordering of a stack of layers and their orientation, very similar to [[What is the card]], in the sense that you need to picture which end of the booklet youre picking from and which way round the pages should be. 
I used a vector approach here, and eliminating elements from the vector as soon as I added the pages in, which is a pretty terrible way of solving the problem. However, since the test case size can only be up to 100 and there are no strict memory requirements, this method works just fine.
# Code
---
```cpp
void solve(int n)
{
	cout << "Printing order for " << n << " pages:" << endl;
	vector<int> pageorder(n,0);
	iota(pageorder.begin(), pageorder.end(), 1);
	while((int)pageorder.size() % 4){
		pageorder.pb(0);
	}

	int counter = 1;
	while(!pageorder.empty()) {
		pair<int,int> front = mp(pageorder.back(), pageorder[0]);
		if(front != mp(0,0))
		cout << "Sheet " << counter << ", front: " << ((front.first == 0) ? "Blank" : to_string(front.first)) << ", " << ((front.second == 0) ? "Blank" : to_string(front.second)) << endl;

		pair<int,int> back  = mp(pageorder[1], pageorder[(int)pageorder.size()-2]);
		if(back != mp(0,0))
		cout << "Sheet " << counter << ", back : " << ((back.first == 0) ? "Blank" : to_string(back.first)) << ", " << ((back.second == 0) ? "Blank" : to_string(back.second)) << endl;
		
		pageorder.erase(pageorder.begin());
		pageorder.erase(pageorder.begin());
		pageorder.pop_back();
		pageorder.pop_back();
		counter++;
	}

}
```