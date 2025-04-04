#bio
# Lucky numbers
---
> A hard BIO 2014 Q1 


# Explanation
---
I found this problem to be very strange and difficult for it being a question 1. took over 30 minutes to solve, which is not ideal. 

# Code
---
```cpp
void solve(int tc)
{
	int n; cin >> n;

	vector<int> tmp1(20002); iota(tmp1.begin(), tmp1.end(),1);
	vector<int> numslist; // initially all odd numbers
	for(auto i : tmp1) 
	{
		if(i % 2)
			numslist.pb(i);
	}

	vector<int> lucky = {1};
	unordered_map<int,bool> islucky; islucky[1] = true;
	
	int gen = 1500; // number of luckies to generate
	while(gen--)
	{
		int nextlucky;
		for(int i = 0; i < numslist.size(); i++)
		{
			if(!islucky[numslist[i]])
			{
				nextlucky = numslist[i];
				int nth = numslist[i]; 
				vector<int> newlist; 
				//cout << nth << "N\n";
				for(int j = 0; j < numslist.size(); j++)
				{
					if( (j+1) % nth != 0)
					{
						newlist.pb(numslist[j]);
					}
					else{
						//cout << "LOL\n\n\n\n\n\n\n\n\n\n";
					}
				}
				//cout << nextlucky << "\n";
				numslist = newlist;
				lucky.pb(nextlucky);
				islucky[nextlucky] = true; 
				break;
			}
		}
	}

	int small,big;
	int tmpn = n;
	// find next biggest
	while(tmpn--)
	{
		if(islucky[tmpn]) {
			small = tmpn;
			tmpn = n;
			break;
		}
	}
	while(tmpn++)
	{
		if(islucky[tmpn]) {
			big = tmpn;
			tmpn = n;
			break;
		}
	}

	cout << small << " " << big;
	

	/*
	for(auto i : lucky){
		cout << i << "\n";
	}
	*/

}
```