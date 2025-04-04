# nimionese
---
>[!summary] CF gym 100800I. Long [[ad hoc]] problem. Took around 45 minutes


# Explanation
---
Requires a decent amount of [[Algorithms/string|string]] manipulation and tokenising. Just have to do what the problem says. 

# Code
---
```cpp
vector<char> cons = {'b','c','d','g','k','n','p','t'};
vector<char> endings = {'a', 'o', 'u'};

char consonantate(char x) {
	bool upper = isupper(x);
	x = tolower(x);
	for(int i = 0; i < 26; i++){
		char before = (char)max((int)'a', x-i);
		char after = (char)min((int)'z', x+i);
		if(find(cons.begin(), cons.end(), before) != cons.end()){
			return (upper ? toupper(before) : tolower(before));
		}
		if(find(cons.begin(), cons.end(), after) != cons.end()){
			return (upper ? toupper(after) : tolower(after));
		}
	}
	return (upper ? toupper(x) : tolower(x));
}



void solve()
{
	string rawinp; getline(cin, rawinp);
	stringstream ss(rawinp);

	vector<vector<string>> tokens;
	string tmp;
	while(ss >> tmp){
		vector<string> s;
		int ptr =-1;
		while(tmp.find("-", ptr+1) != std::string::npos){
			int start = ptr;
			ptr = tmp.find("-", ptr+1);
			s.pb(string(tmp.begin()+start+1 ,tmp.begin()+ptr));
		}
		s.pb(string(tmp.begin()+ptr+1, tmp.end()));
		tokens.pb(s);
	}

	// consonantate first character
	// b, c, d, g, k, n, p, t
	for(auto &i : tokens){
		i[0][0] = consonantate(i[0][0]);
	}

	// consonantate subsequent syllables
	for(int i = 0; i < tokens.size(); i++){
		for(int j = 1; j < tokens[i].size(); j++){
			for(int k = 0; k < tokens[i][j].size(); k++){
				if(find(cons.begin(), cons.end(), tokens[i][j][k]) != cons.end()){
					tokens[i][j][k] = tolower(tokens[i][0][0]);
				}
			}
		}
	}

	// suffixes
	for(int i = 0; i < tokens.size(); i++){
		if(find(cons.begin(), cons.end(), tolower(tokens[i].back().back())) != cons.end()){
			for(int j = 0; j < 26; j++){
				char before = (char)max((int)'a', tolower(tokens[i].back().back())-j);
				char after = (char)min((int)'z', tolower(tokens[i].back().back())+j);
				if(find(endings.begin(), endings.end(), tolower(before)) != endings.end()){
					switch(tolower(before)){
						case 'a':
							tokens[i].back().append("ah");
							break;
						case 'o':
							tokens[i].back().append("oh");
							break;
						case 'u':
							tokens[i].back().append("uh");
							break;
					}
					break;
				}
				if(find(endings.begin(), endings.end(), tolower(after)) != endings.end()){
					switch(tolower(after)){
						case 'a':
							tokens[i].back().append("ah");
							break;
						case 'o':
							tokens[i].back().append("oh");
							break;
						case 'u':
							tokens[i].back().append("uh");
							break;
					}
					break;
				}
			}
		}
	}


	for(auto i : tokens){
		for(auto j : i)
			cout << j;
		cout << " ";
	}

}
```