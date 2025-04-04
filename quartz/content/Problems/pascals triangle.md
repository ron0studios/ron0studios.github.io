# pascals triangle
---
>[!summary] leetcode 118. an easy problem. took literally 6 mins


# Explanation
---
it is a [[pascals triangle]] problem, where you implement the solution by creating new arrays and borrowing values from the previous array.
# Code
---
```cpp
vector<vector<int>> generate(int numRows) {
	vector<vector<int>> out = {{1}};
	for(int i = 2; i <= numRows; i++){
		out.push_back(vector<int>(i,0));
		out[i-1][0] = 1;
		out[i-1][i-1] = 1;
		for(int j = 1; j < i-1; j++){
			out[i-1][j] = out[i-2][j] + out[i-2][j-1];
		}
	}
	return out;
}
```