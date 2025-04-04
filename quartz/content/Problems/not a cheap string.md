# not a cheap string
---
>[!summary] codeforces #805 div3 D


# Explanation
---
This is a regular [[Greedy]] problem that requires you to remove the biggest letters first. You have to optimise by storing the indices of the elements in a vector

> [!warning]
>  vector::pop_back is **WAY** faster than vector::erase, use it when possible!

# Code
---
```cpp

void solve(int tc)
{
	vector<pair<char,int>> chars;
	string w; cin >> w;
	int p;	  cin >> p;
	

	int sum = 0;
	for(int i = 0; i < w.length(); i++){
		sum += w[i]-'a'+1;
		
		chars.pb(mp(w[i],i));
	}
	stable_sort(chars.begin(),chars.end());
	//reverse(chars.begin(),chars.end());

	if(sum <= p)
	{
		cout << w << "\n";
		return;
	}

	vector<int> remove;
	while(w.length())
	{
		//cout << w << " ";
		if(sum <= p)
			break;

		auto mx = chars.back();//max_element(w.begin(),w.end()); 
		sum -= (mx.first)-'a'+1;
		chars.pop_back();
		//w.erase(mx.second);
		//chars.erase(chars.begin());
	}

	unordered_map<int,bool> exclude;
	for(auto i : chars)
		exclude[i.second] = true;

	string out;
	for(int i = 0; i < w.length(); i++)
	{
		if(exclude.count(i))
		{
			out += w[i];
		}
	}
	cout << out << "\n";

}


```