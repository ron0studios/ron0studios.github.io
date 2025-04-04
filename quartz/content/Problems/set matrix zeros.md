# set matrix zeros
---
>[!summary] leetcode 73. simple problem. took 20 mins


# Explanation
---
This problem requires that we use $\pmb{\mathcal{O}(1)}$ space but there is no major constraint on the time^[I am, however, assuming it is $\pmb{\mathcal{O}(N^2)}$]
For each element in the [[matrix]], we will need to check if that cell contains or shares a row/column with an existing zero. If this is the case, we set it to some "transition" value, and then AFTERWARDS update all the transition values to zero. 
This is not optimal but sufficient. If you *do* want better performance though you can iterate through the rows and columns instead!

# Code
---
```cpp
int n = matrix.size();

int m = matrix[0].size();

for(int i = 0; i < n; ++i){

for(int j = 0; j < m; ++j){

if(matrix[i][j]==0) continue;

bool flag = false;

for(int k = 0; k < max(n,m); ++k){

if((k < n && matrix[k][j] == 0) || (k < m && matrix[i][k] == 0)){

flag = true;

break;

}

}

  
  

if(flag) matrix[i][j] = INT_MAX-109586;

}

}

  

for(int i = 0; i < n; i++)

for(int j = 0; j < m; j++)

if(matrix[i][j] == INT_MAX-109586)

matrix[i][j] = 0;
```