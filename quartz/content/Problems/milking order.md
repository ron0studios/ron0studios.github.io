# milking order
---
>[!summary] Hard-ish usaco problem


# Explanation
---
This is a pretty simple [[ad hoc]] problem, which took me *way* longer than it should have. 

Essentially there are 3 observations:
- If `1` is already given a fixed position in the order, that position is the earliest it can be. 
- if `1` is part of the social hierarchy, place the cows in the hierarchy in the earliest empty spots^[after the fixed cows are placed] until you reach the earliest place `1` can be placed. 
- if `1` is neither in the hierarchy or already placed, place the cows in the latest emty spots possible. For this case, loop through the hierarchy backwards and start from the end of the order. 

# Code
---
```cpp

void solve()
{
	freopen("milkorder.in","r",stdin);
	freopen("milkorder.out","w",stdout);
	int n,m,k; cin >> n >> m >> k;
	vector<int> harchy(m,0);
	vector<int> order(n,0);

	unordered_map<int,int> has_harchy;
	unordered_map<int,int> has_order;

	for(int i = 0; i < m; i++)
	{
		cin >> harchy[i];
		has_harchy[harchy[i]] = i;
		//if(harchy[i] == 1) harchy.erase(harchy.begin()+i);
	}
	for(int i = 0; i < k; i++)
	{
		int a,b; cin >> a >> b;
		order[b-1] = a;
		has_order[a] = b;
	}
/*
	for(auto i : harchy)
	{
		cout << i << " ";
	}
	cout << "\n";
	
	for(auto i : order)
	{
		cout << i << " ";
	}
	cout << "\n";
*/

	/*
	for(auto i : order)
		cout << i << " ";
	cout << "\n";
	*/
	// case 1, 1 is already placed
	if(has_order.count(1))
	{
		cout << has_order[1] << "\n";
	
	}
	// case 2, 1 in hierarchy (we place as early as possible)
	else if(has_harchy.count(1)) 
	{
		for(int i = 0; i < m; i++)
		{

			if(has_order.count(harchy[i])) continue;

			for(int j = 0; j < n; j++)
			{
				if(order[j] == 0)
				{
					if(i == 0){
						order[j] = harchy[i];
						if(harchy[i]==1) {cout << j+1; return;}
						break;
					}
					else 
					{
						int last;
						for(int k = j-1; k >= 0; k--)
						{
							if(find(harchy.begin(),harchy.end(),order[k]) != harchy.end())
							{last = order[k]; break;}
						}
						if(last == harchy[i-1])
						{
							order[j] = harchy[i];

							if(harchy[i]==1) {cout << j+1; return;}
							break;
							
						}
					}
				}
			}
		}
	}
	// case 3, 1 is neither in hierarchy or placed (we place as late as possible)
	else
	{
		for(int i = m-1; i >= 0; i--)
		{
			if(has_order.count(harchy[i])) continue;

			for(int j = n-1; j >= 0; j--)
			{
				if(order[j] == 0)
				{
					if(i == m-1){
						order[j] = harchy[i];
						break;
					}
					else if(order[j+1] == harchy[i+1])
					{
						order[j] = harchy[i];
					}
				}
			}
		}
	}

	/*
	for(auto i : order)
		cout << i << " ";
	cout << endl;
	*/

	int idx = 0;
	for(int i = 0; i < n; i++)
	{
		if(order[i] == 0){
			idx = i;
			break;
		}
	}
	cout << idx+1;
}


```