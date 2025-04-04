# word game
---
>[!summary] decent CF problem


# Explanation
---
This is an [[ad hoc]] [[ad hoc|implementation]] problem. 
Use [[hash map|hash maps]] to avoid having a slow program.

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	unordered_map<string,bool> pa;
	unordered_map<string,bool> pb;
	unordered_map<string,bool> pc;


	unordered_map<string,bool> all;
	for(int i = 0; i < 3; i++)
	{
		for(int j = 0; j < n; j++)
		{
			string s; cin >> s;
			all[s] = true;
			if(i==0)
			{
				pa[s] = true;
			}
			else if(i==1)
			{
				pb[s] = true;
			}
			else
			{
				pc[s] = true;
			}
		}
	}
	
	vector<int> score(3,0);
	for(auto s : all)
	{
		bool a = pa.count(s.first);
		bool b = pb.count(s.first);
		bool c = pc.count(s.first);
		//cout << a << " " << b << " " << c << "  :  ";

		if(a and b and c)
			continue;

		if(a + b + c == 1)
		{
			if(a)
			{
				score[0] += 3;
			}
			else if(b)
			{
				score[1] += 3;
			}
			else
			{
				score[2] += 3;
			}
			continue;
		}

		if(a + b + c == 2)
		{
			if(a)
			{
				score[0] += 1;
			}
			if(b)
			{
				score[1] += 1;
			}
			if(c)
			{
				score[2] += 1;
			}
			continue;
		}
	}
	for(auto i : score)
		cout << i << " ";
	cout << "\n";

}
```