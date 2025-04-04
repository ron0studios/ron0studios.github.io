# canine poetry
---
>[!summary] Hard CF problem


# Explanation
---
This is partially [[Greedy]] partially [[dynamic programming]].

The main observation is that every palindrome bigger than N=3 can be made from a size 3 or size 2 palindrome. So breaking any number in those palindromes effectively breaks the rest of the palindrome chain.

From now on, there are a few possible solutions. The easiest one is to iterate over a word from left to right. When we encounter a palindrome (of length 2 or 3) ending on the current position, consisting of unmarked elements, we greedily mark this character as the one we want to replace. The number of marked characters is the answer, as it turns out that we can obtain a valid palindrome-less sequence by replacing only the letters on the marked positions. The complexity is O(n).

# Code
---
```cpp
void solve(int tc)
{
	string s; cin >> s;
	vector<int> mask(s.length());
	
	int out = 0;
	for(int i = 1; i < s.length(); i++)
	{
		if(s[i] == s[i-1] and !mask[i-1])
			mask[i] = 1;
		if(i >= 2 and s[i] == s[i-2] and !mask[i-2])
			mask[i] = 1;
		if(mask[i]) out++;
	}
	cout << out << "\n";
}
```