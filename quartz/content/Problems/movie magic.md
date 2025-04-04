#bio
# Movie magic
---
> Difficult recursive problem requiring [[combinatorics]]


# Explanation
---
Unlike usual [[combinatorics]] where you swap sections of a string, in this
algorithm you actually increment/decrement every possible solution, like [[Brute force]],
except that the solution is still fast because checks are made to stop going through **every** possibility. 

> [!info] update
> essentially the code has an array of the count, because the actual order of the numbers do not matter per actor, just how many scenes each actor has done.^[This is true because we're processing each scene in order, so each actor will have done their scenes in the right order anyways, so we dont bother with that.]

# new code
---
```cpp

vector<int> tot_actors;
int n;
map<vector<int>, ll> dp;

ll compute(int scenes, vector<int> count)
{
	if(dp.count(count)) return dp[count];
	if(scenes == 0) return 1;

	ll tot = 0;
	for(int i = 0; i < n; i++)
	{
		if(count[i] == tot_actors[i]) continue;
		if(i != 0 and count[i]+1 > count[i-1]) continue; 
		count[i]++;
		tot += compute(scenes-1,count);
		count[i]--;
	}
	dp[count] = tot;
	return tot;
}

void solve(int tc)
{
	cin >> n;
	tot_actors = vector<int>(n);
	int scenes = 0;
	for(int i = 0; i < n; i++){
		cin >> tot_actors[i];
		scenes += tot_actors[i];
	}

	ll out = compute(scenes, vector<int>(n));
	cout << out;

}

```
# Code
---
```cpp

int compute(vector<int> sleft, vector<int> sdone) {
	if(accumulate(sleft.begin(),sleft.end(),0) == 1)
		return 1;
	int tot = 0; 

	/*	
	for(auto i : sleft)
		cout << i << " ";
	cout << " :::  "; 
	for(auto i : sdone)
		cout << i << " ";
	cout << "\n";
	*/

	for(int i = 0; i < sleft.size(); i++)
	{
		if(sleft[i] > 0)
		{
			if(i==0 or sdone[i-1] > sdone[i]) 
			{
				vector<int> a = sleft;
				a[i] -= 1;
				vector<int> b = sdone;
				b[i] += 1;
				tot += compute(a,b);
			}
		}
	}
	return tot;
}

// movie magic
void solve(int tc)
{
	int n; cin >> n;
	vector<int> actors; inveci(n,actors); 
	vector<int> blank(n,0); 
	cout << compute(actors,blank);
}


```