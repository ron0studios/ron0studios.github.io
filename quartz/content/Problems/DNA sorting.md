# DNA sorting
---
>[!summary] UVA 612. A more algorithmic but fun [[sorting]] problem


# Explanation
---
This problem is a direct application of the classical [[Inversion counting]] algorithm. The test cases require that a solution must be $\mathcal{O}(nlogn)$ or below. 

Below is a description of the inversion index algorithm.

![[Inversion counting|inversion index]]
# Code
---
```cpp
int inversions = 0;
// counts the number of inversions in the array
string invcnt(string arr){
	if(arr.size() < 2) return arr;

	string L = invcnt(string(arr.begin(), arr.begin()+arr.size()/2));
	string R = invcnt(string(arr.begin()+arr.size()/2, arr.end()));
	string O = "";
	int l = 0, r = 0;
	int tmpinvs = 0;
	while(l < L.size() and r < R.size()){
		if(L[l] <= R[r]){
			O += L[l];
			l++;
		} else {
			O += R[r];
			r++;
			inversions += L.size()-l;
			tmpinvs += L.size()-l;
		}
	}


	while(l < L.size()){
		O += L[l++];
	}

	while(r < R.size()){
		O += R[r++];
	}
	//cout << arr << "\t\t" << L << "\t\t" << R << "\t\t" << O << "\t\t" << tmpinvs << endl;

	return O;
}


void solve(int tc)
{
	inversions = 0;
	int n, m; cin >> n >> m;
	
	vector<pair<int, pair<int, string>>> out;
	for(int i = 0; i < m; i++){
		string tmp; cin >> tmp;
		inversions = 0;
		invcnt(tmp);
		out.pb(mp(inversions, mp(i, tmp)));
	}

	sort(out.begin(), out.end());
	for(auto i : out){
		//cout << i.first << "\t" << i.second.second << endl;
		cout << i.second.second << endl;
	}
}
```