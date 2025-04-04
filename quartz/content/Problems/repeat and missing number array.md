# repeat and missing number array
---
>[!summary] InterviewBit. Simple problem. took around 5 mins.


# Explanation
---
[[hash map]] and pass through. Similar to [[find duplicate number]]
# Code
---
```cpp
vector<int> Solution::repeatedNumber(const vector<int> &A) {
	
	vector<int> test(A.size()+1, 0);
	
	int a,b;
	
	for(int i = 0; i < A.size(); i++){
		if(test[A[i]]) a = A[i];
		test[A[i]] = 1;
	}
	for(int i = 1; i <= A.size(); i++){
		if(!test[i]) {
			b = i; break;
		}
	}
	return {a,b};
}
```