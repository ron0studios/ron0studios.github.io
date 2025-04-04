# molar mass
---
>[!summary] UVA 1586. A simple [[ad hoc]] problem. took around 10-15 minutes


# Explanation
---
This problem requires simple [[Algorithms/parsing]] of the actual molecular formulae. After that you just need to do some basic maths and sum up all the molar values using a [[hash map]]^[for convenience, no other useful reason].
# Code
---
```cpp
void solve(int tc)
{
	string s; cin >> s;
	vector<pair<char,int>> tokens = {mp(s[0],1)};
	for(int i = 1; i < s.size(); i++){
		if(isalpha(s[i])){
			tokens.pb(mp(s[i], 1));
		}else{
			string tmp;
			while(i < s.size()){
				if(isalpha(s[i])){
					i--;
					break;
				}
				tmp += s[i];
				i++;
			}
			tokens.back().second = stoi(tmp);
		}
	}

	unordered_map<char, float> molars;
	molars['C'] = 12.01;
	molars['H'] = 1.008;
	molars['O'] = 16.00;
	molars['N'] = 14.01;

	float out = 0;
	for(auto i : tokens){
		out += molars[i.first] * i.second;
	}
	cout << fixed << setprecision(3) << out << endl;
}
```