# Anya and 1100
---
>[!summary] Codeforces 2036C.  A fiddly [[ad hoc]] problem. Took around 40 minutes


# Explanation
---

Maintin a count of the number of occurences of "1100", and after every change, check if updating that bit actually creates a new 1100 somewhere else in the string or not. We can guarantee and assume that changing a bit **will not** create or remove more than 1 match. 

# Code
---
```cpp

void solve(int tc)
{
	string s; cin >> s;
	int q; cin >> q;
	vector<int> locs(s.size(),0);
	int matches = 0;
	for(int i = 3; i < s.size(); i++){
		if( s.substr(i-3, 4) == "1100"){
			locs[i-3]=1;
			locs[i-2]=2;
			locs[i-1]=3;
			locs[i]=4;
			matches ++;
		}
	}
	while(q--){
		int idx, v; cin >> idx >> v;
		idx--;
		s[idx] = v ? '1' : '0';


		if(locs[idx]){
			string newstr = s.substr(idx-locs[idx]+1, 4);
			int locidx = locs[idx];
			if(newstr=="0100") {
				matches--;
				locs[idx-locidx+1] = 0;
				locs[idx-locidx+2] = 0;
				locs[idx-locidx+3] = 0;
				locs[idx-locidx+4] = 0;
				if(idx-locidx-2 >= 0){
					if(s.substr(idx-locidx-2,4) == "1100"){
						locs[idx-locidx-2] = 1;
						locs[idx-locidx-1] = 2;
						locs[idx-locidx] = 3 ;
						locs[idx-locidx+1] = 4;
						matches++;
					}
				}
			} else
			if(newstr=="1000") {
				matches--;
				locs[idx-locidx+1] = 0;
				locs[idx-locidx+2] = 0;
				locs[idx-locidx+3] = 0;
				locs[idx-locidx+4] = 0;
				if(idx-locidx >= 0 and s[idx-locidx] == '1'){
					locs[idx-locidx] = 1;
					locs[idx-locidx+1] = 2;
					locs[idx-locidx+2] = 3;
					locs[idx-locidx+3] = 4;
					matches++;
				}
			} else
			if(newstr=="1110") {
				matches--;
				locs[idx-locidx+1] = 0;
				locs[idx-locidx+2] = 0;
				locs[idx-locidx+3] = 0;
				locs[idx-locidx+4] = 0;
				if(idx-locidx+5 < s.size() and s[idx-locidx+5] == '0'){
					locs[idx-locidx+2] = 1;
					locs[idx-locidx+3] = 2;
					locs[idx-locidx+4] = 3;
					locs[idx-locidx+5] = 4;
					matches++;
				}
			} else
			if(newstr=="1101") {
				matches--;
				locs[idx-locidx+1] = 0;
				locs[idx-locidx+2] = 0;
				locs[idx-locidx+3] = 0;
				locs[idx-locidx+4] = 0;
				if(idx-locidx+7 < s.size() and s.substr(idx-locidx+4,4) == "1100"){
					locs[idx-locidx+4] = 1;
					locs[idx-locidx+5] = 2;
					locs[idx-locidx+6] = 3;
					locs[idx-locidx+7] = 4;
					matches++;
				}
			}
		}
		else{
			for(int i = idx-3; i <= idx; i++){
				if(i<0 or i+3 >= s.size()) continue;
				if(s.substr(i, 4) == "1100"){
					locs[i] = 1;
					locs[i+1] = 2;
					locs[i+2] = 3;
					locs[i+3] = 4;
					matches++;
					break;
				}
			}
		}

		if(matches){
			cout << "YES" << endl;
		}else{
			cout << "NO" << endl;
		}
	}
}
```