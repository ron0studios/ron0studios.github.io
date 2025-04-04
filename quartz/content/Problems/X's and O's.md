
# X's and O's - Facebook hacker cup
https://www.facebook.com/codingcompetitions/hacker-cup/2021/qualification-round/problems/B

## Code
The solution to this problem cannot be done with **pure** brute-force, but several optimisations can be made to keep it within the 6 minute timer. 
Firstly, instead of inputing the grid as a [[matrix]], we can instead create two different vectors of pairs, in which each pair, the i'th pair represents the ith row or column. In each pair, we have the number of X's and O's stored, respectively. We can then simply loop through each row and add it to a [[hash map]] of the smallest number of moves, along with its number of occurences, saving the number itself as well. We also need to record the winning state, since the answer from a row *could* end up being the same as a column, which doesn't make it a unique set. For example
This: 
o **x** o
x **x** x
o **x** o 
is the same as:
o x o
**x** **x** **x**
o x o
```c++
void solve(int tc)
{
	int n; cin >> n;
	vector<pair<int,int>> n_row(n,mp(0,0)); // number of X, and O in each row
	vector<pair<int,int>> n_col(n,mp(0,0)); // number of X, and O in each column

	cout << "Case #" << tc << ": ";

	string def = "";
	for(int i = 0; i < n; i++) // rows
	{
		for(int j = 0; j < n; j++) // columns
		{
			char d; cin >> d;
			def += d;
			if(d=='X')
			{
				n_col[j].first++;
				n_row[i].first++;
			}
			else if(d=='O')
			{
				n_col[j].second++;
				n_row[i].second++;
			}
		}
	}

	unordered_map<int,int> smallest; // { number of moves : different ways }
	int sm = INT_MAX;	

	unordered_map<string, bool> already; // already done rows

	for(int i = 0; i < n; i++)
	{
		if(n_row[i].second > 0) continue;
		smallest[n-n_row[i].first]++;
		sm = min(sm, n-n_row[i].first);
		
		string out = def;
		out.replace(i*n, n, string(n,'X'));
		already[out] = true;
	}

	for(int i = 0; i < n; i++)
	{
		if(n_col[i].second > 0) continue;

		string out = def;
		for(int j = 0; j < n; j++)
		{
			out[(j*n) + i] = 'X'; 
		}
		if(already[out] == true) continue;

		smallest[n-n_col[i].first]++;
		sm = min(sm, n-n_col[i].first);

	}

	if(sm == INT_MAX) 
	{
		cout << "Impossible" << "\n";
	}
	else
	cout << sm << " " << smallest[sm] << "\n";


}
```