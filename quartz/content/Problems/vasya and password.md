# vasya and password
---
>[!summary] Pretty easy codeforces problem


# Explanation
---
A relatively straightforward [[Greedy]]/[[ad hoc]] sort of problem. It shouldn't be 1200 difficulty really

# Code
---
```cpp
#include "bits/stdc++.h"

using namespace std;

#define mp make_pair
#define pb push_back
#define INF (int)1e9
#define EPS 1e-9
#define PI 3.1415926535897932384626433832795
#define MOD 1000000007
#define ll long long
#define v(i) vector<i>
#define inveci(n,a) for(int integer=0; integer < n; integer++) {int abc123; cin >> abc123; a.pb(abc123);}
typedef unsigned int uint;
template <typename T,typename U>                                                   
std::pair<T,U> operator+(const std::pair<T,U> & l,const std::pair<T,U> & r) {   
    return {l.first+r.first,l.second+r.second};                                    
}


void solve(int tc)
{
	string s; cin >> s; 
	//cout << "S: " <<  s << endl;
	int uppercase = 0;
	int lowercase = 0;
	int number = 0;

	for(auto i : s)
	{
		if(isdigit(i)) number++;
		else if(isupper(i)) uppercase++;
		else lowercase++;
	}

	if(uppercase and lowercase and number) {
		cout << s << endl;
		return;
	}

	if(not uppercase and not lowercase){
		s[0] = 'A';
		s[1] = 'a';
		cout << s << endl;
		return;
	}

	if(not uppercase and not number) {
		s[0] = 'A';
		s[1] = '1';
		cout << s << endl;
		return;
	}

	if(not lowercase and not number) {
		s[0] = 'a';
		s[1] = '1';
		cout << s << endl;
		return;
	}

	if(not uppercase){
		for(int i = 0; i < (int)s.length(); i++)
		{
			if(isdigit(s[i]) and number == 1) continue;
			if(islower(s[i]) and lowercase == 1) continue;
			s[i] = 'A';
			break;
		}
	}
	else if(not lowercase){
		for(int i = 0; i < (int)s.length(); i++)
		{
			if(isdigit(s[i]) and number == 1) continue;
			if(isupper(s[i]) and uppercase == 1) continue;
			s[i] = 'a';
			break;
		}
	}
	else {
		for(int i = 0; i < (int)s.length(); i++)
		{
			if(isupper(s[i]) and uppercase == 1) continue;
			if(islower(s[i]) and lowercase == 1) continue;
			s[i] = '1';
			break;
		}
	}

	cout << s << endl;
	

}

int main()
{
    ios_base::sync_with_stdio(0), cin.tie(0), cout.tie(0);
    int tc; cin >> tc;
    int ogtc = tc;
    while(tc--)
    {
        solve(ogtc-tc);
    }
    return 0;
}
```