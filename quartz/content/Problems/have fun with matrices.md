# have fun with matrices
---
>[!summary] UVA 11360. A simple [[ad hoc]] [[matrix|grid]] problem. Took around 11 minutes


# Explanation
---
This problem simply requires you to perform [[matrix]] manipulations while processing various queries. The c++ `swap` function was **extremely** useful here.
No extra optimisations are required, although i did find this pretty simple and neat trick to transpose a matrix in $\pmb{\mathcal{O}(\frac{N^{2}}{2})}$ time. If you adjust the `j` loop when scanning a matrix to begin with `i+1`, you end up only scanning the top right half of the matrix, diagonally.
```cpp
for(int i = 0; i < n; i++){
	for(int j = i+1; j < n; j++){
		// perform code here...
	}
}
```
$$\begin{matrix}
1 & \pmb{\Huge{2}} & \pmb{\Huge{3}} \\
4 & 5 & \pmb{\Huge{6}} \\ 
7 & 8 & 9 \\ 
\end{matrix}$$
Above you can see that by performing this loop, you will only traverse *2,3 and 6*. What we can do then, is **swap** each highlighted element with its *mirror* opposite along the **diagonal** of the matrix.  i.e.
```cpp
swap(mat[i][j], mat[j][i]);
```

This will transpose the matrix **in place!**
# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n; 
	vector<vector<int>> mat(n, vector<int>(n, 0));
	for(int i = 0; i < n; i++){
		for(int j = 0; j < n; j++){
			char c; cin >> c;
			mat[i][j] = c-'0';
		}
	}

	int q; cin >> q;
	while(q--){
		string ins; cin >> ins;
		if(ins == "inc"){
			for(int i =0 ; i < n; i++){
				for(int j = 0; j < n; j++){
					mat[i][j]++;
					mat[i][j] %= 10;
				}
			}
		}
		else
		if(ins == "dec"){
			for(int i =0 ; i < n; i++){
				for(int j = 0; j < n; j++){
					mat[i][j]--;
					if(mat[i][j] < 0) mat[i][j] += 10;
				}
			}
		}
		else
		if(ins == "transpose") {
			for(int i = 0; i < n; i++){
				for(int j = i+1; j < n; j++){
					swap(mat[i][j], mat[j][i]);
				}
			}
		}
		else
		if(ins == "row"){
			int a,b; cin >> a >> b;
			a--; b--;
			swap(mat[a], mat[b]);
		}
		else { // col
			int a,b; cin >> a >> b;
			a--; b--;
			for(int i = 0; i < n; i++){
				swap(mat[i][a], mat[i][b]);
			}
		}
	}

	cout << "Case #" << tc << endl;
	for(int i = 0; i < n; i++){
		for(int j = 0; j < n; j++){
			cout << mat[i][j];
		}
		cout << endl;
	}
	cout << endl;
}
```