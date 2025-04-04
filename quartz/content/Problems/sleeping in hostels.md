# sleeping in hostels
---
>[!summary] UVA 13181. A relatively simple array problem. Took around 20 mins


# Explanation
---
To solve this problem you need to essentially find the maximum distance between any two `X` values, inclusive of the beginning and end of the array. Once we find this maximum distance, the maximum a person can be distanced between the two `X` values will be found by using the formula: $$\lfloor\frac{x-1}{2}\rfloor$$
**However**, if our maximum distance is between an `X`  and boundary, i.e. the beginning or end of the array. Then we can maximise our distance by simply sleeping at the end of the array, or beginning of it, since there is no second `X` value to compare with. The formula for this is simply just $$x-1$$
# Code
---
```cpp
void solve(string s)
{
	vector<int> beds;
	stringstream ss(s);
	char c;
	vector<int> dists;
	int lastbed = -1;
	while(ss >> c){
		if(c == 'X'){
			beds.pb(1);
			dists.pb(beds.size()-2-lastbed);
			lastbed = beds.size()-1;
			if(dists.size() == 1){
				dists.back()--;
			}
			else{
				dists.back() = (dists.back()-1)/2;
			}
		}
		else{
			beds.pb(0);
		}
	}
	dists.pb(beds.size()-1-lastbed);
	dists.back()--;
	lastbed = beds.size()-1;
	auto mx = max_element(dists.begin(), dists.end());

	cout << *mx << endl;
}
```