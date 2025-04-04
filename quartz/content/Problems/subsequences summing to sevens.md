# subsequences summing to sevens
---
> USACO 2016 silver, January, problem 2


# Explanation
---
A combination of [[prefix sum]] and modular arithmetic is used. It is necessary to use modulus 7 on the sum, since complete search is too slow.

# Code
---
```cpp

void solve()
{
	freopen("div7.in","r",stdin);
	int n; cin >> n; 
	vector<int> cows;
	vector<ll> presum;
	
	for(int i = 0; i < n; i++)
	{
		int x; cin >> x;
		cows.pb(x);
	}


	presum.pb(cows[0]);
	for(int i = 1; i < cows.size(); i++)
	{
		presum.pb(presum.back() + cows[i]);
	}

	for(auto &i : presum)
	{
		i = i%7;
	}

	

	vector<int> leftmost(7,INT_MAX);
	vector<int> rightmost(7,-INT_MAX);

	for(int i = 0; i < 7; i++)
	{
		for(int j = 0; j < n; j++)
		{
			if(presum[j] == i)
			{
				leftmost[i] = j;
				break;
			}
		}
		for(int j = n-1; j >= 0; j--)
		{
			if(presum[j] == i)
			{
				rightmost[i] = j;
				break;
			}
		}
	}
	vector<int> diff; 
	for(int i = 0; i < 7; i++)
	{
		diff.pb(rightmost[i]-leftmost[i]);
	}

	freopen("div7.out","w",stdout);

	cout << *max_element(diff.begin(),diff.end()) << endl;
}


```