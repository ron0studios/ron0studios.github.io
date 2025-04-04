# party games
---
>[!summary] UVA 1610. A tedious [[string|strings]] problem with a lot of corner cases. Took 1hr 30m


# Explanation
---
This problem requires some [[sorting]], especially when it comes to dealing with ordering the strings. For this problem we need to compare strings in **lexicographic** order,  meaning that we compare each character in both strings and see if $A_{i}> B_i$. However, unlike the default c++ string comparison, if string *A* is longer than string *B*, and the strings are equal, the longer string will be greater than the shorter one. 

We find the median of the sorted strings array and find a string that fits between the two median values^[there will always be 2 median values since the length of the array is given to be even in the problem statement]. However this string needs to be as **short as possible**, and as low as possible in *lexicographic* order. These two conditions mean that we can narrow our solution greatly.

First we take the largest common prefix [[longest common prefix]] and for each following character we follow the logic in lines `36` and onwards.^[there is a **lot** to go through. Essentially the 4 options are: next character is as small as possible, one more than that, as big as possible or one less than that. ]
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


void solve(int n)
{
	vector<string> names(n,"");
	for(int i = 0; i < n; i++)
		cin >> names[i];

	sort(names.begin(), names.end(), string_greater);

	string b = names[n/2 -1];
	string a = names[n/2];

	string oga = a;
	string ogb = b;

	string out = "";
	while(a.size() and b.size() and a[0] == b[0]){
		out += a[0];
		a = string(a.begin()+1, a.end());
		b = string(b.begin()+1, b.end());
	}

	while(string_greater(oga, out) or !string_greater(ogb, out)){
		if(a.size()==1){
			out += a[0];
			cout << out << endl;
			return;
		}

		if(a.size()){
			out += min(25, a[0]-'A'+1)+'A';
			if(!string_greater(oga, out) and string_greater(ogb, out)){
				cout << out << endl;
				return;
			}
			out = string(out.begin(), out.end()-1);
		}

		if(b.size()){
			out += max(0,b[0]-'A'-1)+'A';
			if(!string_greater(oga, out) and string_greater(ogb, out)){
				cout << out << endl;
				return;
			}
			out = string(out.begin(), out.end()-1);

			out += b[0];
			if(!string_greater(oga, out) and string_greater(ogb, out)){
				cout << out << endl;
				return;
			}
			out = string(out.begin(), out.end()-1);
		}

		out += a[0];
		if(a.size()) a = string(a.begin()+1, a.end());
		if(b.size()) b = string(b.begin()+1, b.end());
	}
	cout << out << endl;
}
```