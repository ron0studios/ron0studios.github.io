# mirror mirror
---
>[!summary] UVA 466. A relatively simple [[matrix]] problem. Took under 30 minutes.


# Explanation
---
This problem is very similar to [[have fun with matrices]], in that we are simply implementing basic [[matrix]] operations. Note that, to optimise programming time, the **order** of which we pass our checks can be very handy. 
Notice that I pass the "preserved" check first, *then* a check for rotations, and *THEN* a check for combinations. This prevents me from creating a spaghetti mess of if statements with the implementation.
I also implemented a generic `rotate90` function that I can simply call *multiple times* to get the rotation I want. 
The `flip` function was relatively straightforward, just need to mess around with how you index the output matrix.

> [!question] blooper 
> I failed my first submission because I spelt `transformed` as `tranformed` in *line 78* 🤦‍♂
# Code
---
```cpp
vector<vector<int>> rotate90(vector<vector<int>> mat)
{
	vector<vector<int>> out(mat[0].size(), vector<int>(mat.size(), 0));
	for(int i = 0; i < mat.size(); i++){
		for(int j =0; j < mat[0].size(); j++){
			out[j][out.size()-i-1] = mat[i][j];
		}
	}
	return out;
}

vector<vector<int>> flip(vector<vector<int>> mat)
{
	vector<vector<int>> out(mat.size(), vector<int>(mat[0].size(), 0));
	for(int i = 0; i < mat.size(); i++){
		for(int j =0; j < mat[0].size(); j++){
			out[out.size()-i-1][j] = mat[i][j];
		}
	}
	return out;
}

void solve(int n, int tc)
{
	vector<vector<int>> mat(n, vector<int>(n,0));
	vector<vector<int>> newmat(n, vector<int>(n,0));
	for(int i = 0; i < n; i++){
		for(int j = 0; j < n; j++){
			char c; cin >> c;
			if(c == 'X'){
				mat[i][j] = 1;
			}
			else mat[i][j] = 0;
		}

		for(int j = 0; j < n; j++){
			char c; cin >> c;
			if(c == 'X'){
				newmat[i][j] = 1;
			}
			else newmat[i][j] = 0;
		}
	}

	if(mat == newmat){
		cout << "Pattern " << tc << " was preserved." << endl;
		return;
	}

	for(int i = 0; i < 4; i++){
		vector<vector<int>> trans = mat;

		for(int j = 0; j < i; j++) trans = rotate90(trans);

		if(trans == newmat){
			cout << "Pattern " << tc << " was rotated " << i*90 << " degrees." << endl;
			return;
		}
	}



	for(int i = 0; i < 4; i++){
		vector<vector<int>> trans = flip(mat);

		for(int j = 0; j < i; j++) trans = rotate90(trans);

		if(trans == newmat){
			cout << "Pattern " << tc << " was reflected vertically";
			if(i) {
				cout << " and rotated " << i*90 << " degrees." << endl;
			}
			else cout << "." << endl;
			return;
		}
	}

	cout << "Pattern " << tc << " was improperly tranformed." << endl;
}
```