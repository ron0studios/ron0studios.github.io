# remove two letters
---
>[!summary] Neat CF problem


# Explanation
---
A nice [[ad hoc]] problem with a trick to solve.

You can only remove two consecutive letters, and the issue that prevents us from just saying $n-1$ for every testcase is the fact that two operations can yield the same string. Let's find out where that is the case.

The only situation where two operations yield the same string is when both operations are next to each other, i.e $[i,i+1]$  and $[i+1,i+2]$. 

We only get the same yielded string from both these operations if the leftover character is the same, so $i+2$ would be the leftover character for the first operation and $i$ would be the leftover for the second, so if they are the same then we would yield the same result.

So if we look at all the situations where we get the same result and substract it from $n-1$, we get our answer.

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;
	string s; cin >> s;

	int out = 0;
	for(int i = 0; i < n-2; i++){
		if(s[i] == s[i+2])
		{
			out ++;
		}
	}
	cout << n-1-out << endl;
}
```