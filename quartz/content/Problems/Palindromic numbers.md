#implementation 
#bio
# Palindromic numbers
---
> question 1 from round 1 of the (BIO) British informatics olympiad 2019 (i think). this is probably one of the hardest Q1s from round 1 so far. Much harder than other problems like [[Coloured triangles]], but simpler to read as a problem!
> The question is simply to find **the next strictly higher palindrome** after a given inputted integer.


# Explanation
---
> [!note] use stoull() instead of stoi() because of edge cases!

You run a first pass that converts the number to a palindrome based on whether its odd or not
While the number is less than the input, (i.e a solution hasnt been found), find the next highest palindrome by adding 1 to the "half" of the palindrome ( the part that you flip to make the full number). 
In the case that there are all 9s, just create a new string of zeroes (of a greater length) and set the first and last characters to "1"

# Code
---

```cpp
#include <bits/stdc++.h>

using namespace std;

#define mp make_pair
#define pb push_back
#define INF (int)1e9
#define EPS 1e-9
#define PI 3.1415926535897932384626433832795
#define MOD 1000000007
#define ll long long
#define v(i) vector<i>
#define inveci(n,a) for(int integer=0; integer < n; integer++) {int abc123; cin >> abc123; a.pb(abc123);}A
typedef unsigned int uint;
template <typename T,typename U>                                                   
std::pair<T,U> operator+(const std::pair<T,U> & l,const std::pair<T,U> & r) {   
    return {l.first+r.first,l.second+r.second};                                    
}



void solve(int tc)
{
	string s; cin >> s;
	string curr = s;

	// initial pass, convert to a palindrome
	if(curr.length() % 2 == 0) { // even
		string half = string(curr.begin(),curr.begin()+ceil((float)curr.length()/2.0));
		curr = half + string(half.rbegin(),half.rend());
	}
	else {
		string half = string(curr.begin(),curr.begin()+ceil((float)curr.length()/2.0));
		string to_rev = string(half.begin(), half.end()-1);
		curr = half + string(to_rev.rbegin(), to_rev.rend());
	}

	while(stoull(curr) <= stoull(s))
	{

		// if all 9s 
		if(to_string(stoull(curr) + 1).length() > curr.length())
		{
			curr = string(curr.length() + 1, '0');

			curr[0] = '1'; curr.back() = '1';

			continue;
		}

		if(curr.length() % 2 == 0) { // even
			string half = string(curr.begin(),curr.begin()+ceil((float)curr.length()/2.0));
			
			half = to_string( stoull(half) + 1 );

			curr = half + string(half.rbegin(),half.rend());
		}
		else {
			string half = string(curr.begin(),curr.begin()+ceil((float)curr.length()/2.0));
			half = to_string( stoull(half) + 1 );

			string to_rev = string(half.begin(), half.end()-1);
			curr = half + string(to_rev.rbegin(), to_rev.rend());
		}
	}
	cout << curr << "\n";
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