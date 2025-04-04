# consanguine calculations
---
>[!summary] UVA 1061. A very tedious [[ad hoc]] problem. took around 3 hours


# Explanation
---
This problem is very [[Brute force]] like, and I have implemented a solution that takes all the possibilities into account by permuting each combination and seeing which blood types are valid. A decent amount of [[string|string processing]] is needed.

My code is incredibly spaghetti. I struggle to understand it even now, right after finishing the problem. It is a very messy implementation sorry 😭. 

# Code
---
```cpp
// parent a parent b child test case
void solve(string parenta, string parentb, string child, int tc)
{
	cout << "Case " << tc << ": ";
	unordered_map<string, vector<char>> abo;
	abo["A"] = { 'A', 'O' };
	abo["B"] = { 'B', 'O' };
	abo["AB"] = { 'A', 'B'};
	abo["O"] = {'O'};
	map<vector<char>, string> btype;
	btype[{'A','A'}] = "A" ;
	btype[{'A','O'}] = "A" ;
	btype[{'B','B'}] = "B" ;
	btype[{'B','O'}] = "B" ;
	btype[{'A','B'}] = "AB" ;
	btype[{'O','O'}] = "O" ;



	vector<string> out;
	if(child=="?"){
		vector<char> abosA = abo[string(parenta.begin(), parenta.end()-1)];
		vector<char> abosB = abo[string(parentb.begin(), parentb.end()-1)];
		
		set<vector<char>> combs_;
		for(int i = 0; i < abosA.size(); i++){
			for(int j = 0; j < abosB.size(); j++){
				combs_.insert({min(abosA[i], abosB[j]), max(abosA[i], abosB[j])});
			}
		}

		vector<vector<char>> combs;
		for(auto i : combs_)
			combs.pb(i);

		bool plus = false;
		bool minus = false;
		if(parenta.back() == '-' and parentb.back() =='-'){
			minus = true;
		}
		else{
			plus = true;
			minus = true;
		}

		cout << parenta << " " << parentb << " ";
		if(combs.empty()) {
			cout << "IMPOSSIBLE" << endl;
		}
		else {
			set<string> out_;

			for(auto i : combs){
				if(!btype.count(i)) continue;
				if(plus) out_.insert(btype[i] + "+");
				if(minus) out_.insert(btype[i] + "-");
			}
			
			vector<string> out;
			for(auto i : out_){ 
				out.pb(i);
			}

			sort(out.begin(), out.end(), [](string& a, string& b){
					for(auto i : vector<string>({"O-", "O+", "AB-", "AB+", "B-", "B+", "A-", "A+"})) {
						if(i == a) return true;
						if(i == b) return false;
					}
					});

			if(out.size() == 1){
				cout << out[0] << endl;
			}
			else{
				cout << "{";
				for(int i = 0; i < out.size(); i++) {
					cout << out[i];
					if(i < out.size()-1) cout << ", ";
				}
				cout << "}" << endl;
			}
		}


	}
	else{
		string otherparent = parenta == "?" ? string(parentb.begin(), parentb.end()-1) 
											: string(parenta.begin(), parenta.end()-1);
		string otherrh = parenta == "?" ?  string(1, parentb.back())
											: string(1, parenta.back());
		vector<vector<char>> required;
		for(auto i : btype) {
			if(i.second == string(child.begin(), child.end()-1)){
				required.pb(i.first);
			}
		}

		bool plus = false;
		bool minus = false;
		if(child.back() == '-'){
			plus = true;
			minus = true;
		}
		else {
			if(otherrh == "+"){
				plus = true;
				minus = true;
			}else{
				plus = true;
				minus = false;
			}
		}

		set<string> out_;
		for(int i = 0; i < required.size(); i++) {
			if(find(abo[otherparent].begin(), abo[otherparent].end(), required[i][0]) != abo[otherparent].end()) {
				for(auto j : vector<string>({"A","B","AB","O"})) {
					if(find(abo[j].begin(), abo[j].end(), required[i][1]) != abo[j].end()) {
						if(plus) out_.insert(j+"+");
						if(minus) out_.insert(j+"-");
					}
				}
			}

			if(find(abo[otherparent].begin(), abo[otherparent].end(), required[i][1]) != abo[otherparent].end()) {
				for(auto j : vector<string>({"A","B","AB","O"})) {
					if(find(abo[j].begin(), abo[j].end(), required[i][0]) != abo[j].end()) {
						if(plus) out_.insert(j+"+");
						if(minus) out_.insert(j+"-");
					}
				}
			}
		}

		vector<string> out;
		for(auto i : out_)
			out.pb(i);
		sort(out.begin(), out.end(), [](string& a, string& b){
				for(auto i : vector<string>({"O-", "O+", "AB-", "AB+", "B-", "B+", "A-", "A+"})) {
					if(i == a) return true;
					if(i == b) return false;
				}
				});


		if(parenta == "?"){
			if(out.size()){
				if(out.size() == 1){
					cout << out[0] << " ";
				}
				else {
					cout << "{";
					int ptr = 0;
					for(auto i : out){
						cout << i;
						if(ptr < out.size()-1)
							cout << ", ";
						ptr++;
					}
					cout << "} ";
				}
			}
			else {
				cout << "IMPOSSIBLE ";
			}
			cout << parentb << " " << child << endl;
		}
		else{
			cout << parenta << " ";
			if(out.size()){
				if(out.size() == 1){
					cout << out[0] << " ";
				}
				else{
					cout << "{";
					int ptr = 0;
					for(auto i : out){
						cout << i;
						if(ptr < out.size()-1)
							cout << ", ";
						ptr++;
					}
					cout << "} ";
				}
			}
			else {
				cout << "IMPOSSIBLE ";
			}
			cout << child << endl;
		}

	}

}
```