# conversation log
---
>[!summary] CF gym 100800C. A simple [[sorting]] problem which I managed to fumble. took around 30-40 minutes.


# Explanation
---
This needs the same kind of string sorting as in [[party games]], which was giving me a headache because I was trying to spot the bug in the code. All you really need to do is a bunch of set manipulation to find the **intersect** between all the users. a [[hash map]] is recommended to store user data.

# Code
---
```cpp


bool string_greater(const string& l, const string& r){
	int ptr = 0;
	while(ptr < min(l.size(), r.size())){
		if(l[ptr] > r[ptr]) return true;
		if(l[ptr] < r[ptr]) return false;
		ptr++;
	}
	if(ptr == l.size())
		return false;
	return true;
}


void solve()
{

	string tmps; getline(cin, tmps);
	int m = stoi(tmps);

	unordered_map<string, int> wordcount;
	map<string, set<string>> words;

	for(int i = 0; i < m; i++){
		string s; getline(cin, s);
		stringstream ss(s);
		string name; ss >> name;
		while(ss >> s){
			wordcount[s]++;
			words[name].insert(s);
		}
	}


	set<string> out;
	bool first = false;
	for(auto& i : words){
		if(!first){
			out = i.second;
			first = true;
			continue;
		}
		
		vector<string> todelete;
		for(auto &j: out){
			if(!i.second.count(j)) {
				todelete.pb(j);
			}
		}
		for(auto i : todelete)
			out.erase(i);

	}

	if(out.empty()){
		cout << "ALL CLEAR" << endl;
	}

	vector<pair<int,string>> sorted;
	for(auto i : out)
		sorted.pb(mp(wordcount[i], i));

	sort(sorted.begin(), sorted.end(), [&](const pair<int,string>& l, const pair<int, string>& r){
			if(l.first != r.first) return l.first < r.first;
			return string_greater(l.second, r.second);
			});

	for(int i = sorted.size()-1 ;i >= 0; i--)
		cout << sorted[i].second << endl;
}

```