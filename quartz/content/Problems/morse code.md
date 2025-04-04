#bio
# Morse code
---
> BIO '04 q3


# Explanation
---
this is a recursive problem, which *maybe* could be implemented using [[dynamic programming]], but there is no need
You go through a tree with a height of the number of letters in the inputted word, where each layer goes through all possible morse symbols at each prefix of the morsified word. 

# Code
---
```cpp

vector<string> morse = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};

int comb(string mstr, int len)
{
	if(len*4 < mstr.length())
		return 0;
	if(len==0)
		if(mstr.length()==0)
			return 1;
		else
			return 0;

	int total = 0;

	for(auto i : morse){
		if(i.length() > mstr.length()) continue;
		if(i == mstr.substr(0,i.length()))
		{
			total += comb(string(mstr.begin()+i.length(),mstr.end()),len-1);
		}
	}
	return total;
}

void solve(int tc)
{
	string s; cin >> s; 


	//morsify
	string m_s;
	for(auto i : s)
	{
		m_s += morse[i-'a'];
	}
	int c = 0;

	int out = comb(m_s,s.length());
	cout << out;
}


```