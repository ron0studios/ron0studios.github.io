# probably english
---
>[!summary] Atcoder problem


# Explanation
---

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<string> words(n," ");
	for(int i = 0; i < n; i++)
		cin >> words[i];

	for(auto i : words)
	{
		if(i == "and" or i == "not" or i == "that" or i == "the" or i == "you")
		{
			cout << "Yes"; return;
		}
	}
	cout << "No"; 
}
```