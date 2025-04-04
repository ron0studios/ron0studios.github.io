# Sorting parts
---
#implementation 
> A very annoying question because of the way it is phrased.
> https://codeforces.com/contest/1637/problem/A


# Explanation
---
The problem can be brute forced relatively easily but, you have to be very careful with your pointers with .begin() and .end(). Remember that most stl functions in c++ are **NOT inclusive**. But it *may seem* inclusive because of the fact that things like std::sort sort the last element of the array as well. .end() is not actually the last element of an array but **one past the last element**, meaning it exists outside the array by 1, hence it is not inclusive!

C++ provides the fastest [[sorting]] algorithm available (in general) for this question, but it may have been possible to optimise this with a fast sorting algorithm for big datasets, such as [[merge sort]]. 

# Code
---
```c++
// practice codeforces A question 
void solve(int tc)
{
	int n; cin >> n;
	vector<int> a; inveci(n,a)
	
	for(int i = 1; i < n; i++)
	{
		vector<int> l1(a.begin(), a.begin()+i);
		vector<int> l2(a.begin()+i, a.end());

		sort(l1.begin(),l1.end());
		sort(l2.begin(),l2.end());

		l1.insert(l1.end(),l2.begin(),l2.end());

		if(!is_sorted(l1.begin(),l1.end())){
			cout << "YES\n";
			return;
		}
	}
	cout << "NO\n";
}
```