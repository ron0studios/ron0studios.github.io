# Consistency - Facebook hacker cup
 https://www.facebook.com/codingcompetitions/hacker-cup/2021/qualification-round/problems/A1"
 
 ## Code
This problem was solved using a brute force solution  where we simulated the problem for each letter, and find the minimum answer. If there are no vowels, then it would actually be better to turn all consonants into the same vowel, so that case is included in the end. For a quicker runtime, we use a [[hash map]], to store the letters and their occurences in the [[string]].
 ```c++
 bool isvowel(char ch) { return (ch == 'A') || (ch == 'E') ||(ch == 'I') ||(ch == 'O') ||(ch == 'U'); }

void solve(int tc)
{
	string s; cin >> s;
	cout << "Case #" << tc << ":\n";

	unordered_map<char,int> letters;
	int n_vowels = 0;
	int n_cons = 0;

	for(auto i : s)
	{
		letters[i]++;
		if(isvowel(i))
			n_vowels++;
		else
			n_cons++;
	}

	int smallest = INT_MAX;
	for(auto i : letters) // {char, int}
	{
		int x = 0;
			if(isvowel(i.first))
			{	
				x += n_cons;
				x += (n_vowels-letters[i.first]) * 2;
			}
			else
			{
				x += n_vowels;
				x += (n_cons-letters[i.first]) * 2;
			}
	
		smallest = min(x,smallest);
	}

	if(n_cons == 0 || n_vowels == 0)
	{
		cout << min(smallest, (int)s.length()) << "\n";
	}
	else
		cout << smallest << "\n";

}
 ```
 