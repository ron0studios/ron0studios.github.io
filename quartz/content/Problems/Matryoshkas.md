# Matryoshkas
---
>[!summary] OK problem with a *very annoying* optimisation


# Explanation
---
This problem can be implemented easily using [[sorting]] and a [[Greedy]] approach. You can sort all the items in order and use a [[hash map]] to keep counts of things. Just keep looping through the sorted set for contiguous numbers until $n=0$. 


> [!warning] **UNORDERED_MAPS CAN BE SLOW SOMETIMES!** 
> **BE CAREFUL!**
> I spent *AGES* on this problem since I kept failing test case 28. It wasn't due to an infinite loop as I had expected, so I tried creating worst case scenarios, but the code still ran in under 100ms. 
> The issue was in line 5, `unordered_map<int,int> a`. In fact, test case 28 included a very tricky set of prime numbers, which the hash function for an unordered_map can't handle efficiently, leading to a drastic slowdown! In this case, try to use a `map` instead!





# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	map<int,int> a;
 
	for(int i = 0; i < n; i++){
		int x; cin >> x; 
		a[x]++;
	}
 
	vector<int> s;
	for(auto i : a)
		s.pb(i.first);
	sort(s.begin(), s.end());
  
	int out = 0;
	while(n) {
 
		vector<int> s1;
		
 
		n--;
		a[s[0]]--;
		if(a[s[0]] > 0) s1.pb(s[0]);
 
		bool series = true;
 
		for(int i = 1; i < s.size(); i++) {
			n--;
			a[s[i]]--;
			series = true;
 
			if(s[i] > s[i-1] + 1){
				out++;
				series = false;
			}
 
			if(a[s[i]] > 0) s1.pb(s[i]);
		}
		out++;
 
		s = s1;
	}
 
	cout << out << endl;
 
}

```