#bio
# Cards
---
> BIO 2007 Q1. A bit weird, requires combinatorics


# Explanation
---
[[combinatorics]] is required in the formula n!/r!(n-r)! 
there's also a [[hash map]] in place for generating distinct paths to create a sum of 15

All that's then left to do is to use [[complete search#Iteratively| iterative complete search]] using [[bitwise operations]] to loop through all possible subsets of 5^[which isnt computationally difficult to do], and see which ones sum to 15

# Code
---
```cpp

int fact(int n)
{
	if(n==0) return 1;
	return n*fact(n-1);
}

void solve(int tc)
{
	vector<int> cards(5,0);
	unordered_map<int,int> cnt;
	int out = 0;

	for(int i = 0; i < 5; i++) {
		cin >> cards[i];
		cnt[cards[i]]++;
	}

	for(auto i : cnt)
	{
		if(i.second > 1)
		{
			out += fact(i.second)/ (2 * fact(i.second-2));
		}
	}

	for(int i = 0; i <= 31; i++)
	{
		int tmp = 0;
		for(int j = 0; j < 5; j++)
		{
			tmp += ((i >> j)%2) * cards[j];
		}
		if(tmp == 15)
		{
			out++;
		}
	}

	cout << out << endl;

}


```




> [!info]- old code
> ```cpp
> 
> int fact(int n)
> {
> 	if(n<=1) return 1;
> 	return n * fact(n-1);
> }
> 
> map<vector<pair<int,int>>,bool> visited;
> 
> int addsup(vector<pair<int,int>> nums, int sum = 0)
> {
> 
> 	if(sum > 15) return 0;
> 	if(sum == 15){
> 		if(visited[nums])
> 			return 0;
> 		visited[nums] = true;
> 		return 1;
> 	}
> 	if(nums.size() == 0) return 0;
> 	
> 	int tot = 0;
> 	for(int i = 0; i < nums.size(); i++)
> 	{
> 		vector<pair<int,int>> tmp = nums;
> 		tmp.erase(tmp.begin()+i); 
> 
> 		tot += addsup(tmp,sum + nums[i].first);
> 	}
> 
> 	return tot;
> 
> }
> 
> // cards
> void solve(int tc)
> {
> 	visited.clear();
> 	vector<int> inp;
> 	for(int i = 0; i < 5; i++)
> 	{
> 		int x; cin >> x;
> 		inp.pb(x);
> 	}
> 	// 5! = 120
> 	
> 	int points = 0;
> 	map<int,int> same;
> 	for(auto i : inp)
> 		same[i]++;
> 
> 	// n!/r!(n-r)!
> 	for(auto i : same)
> 	{
> 		if(i.second > 1)
> 		{
> 			points += fact(i.second)/(fact(2)*fact(i.second-2));
> 		}
> 	}
> 
> 
> 	vector<pair<int,int>> uid; 
> 	for(int i = 0; i < inp.size(); i++)
> 	{
> 		uid.pb(mp(inp[i],i));
> 	}
> 	points += addsup(uid);
> 
> 	cout << points;
> 
> }
> 
> 
> ```