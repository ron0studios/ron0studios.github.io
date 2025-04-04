#bio
# Shuffling
---
> BIO 2002 Q2. A very fiddly parsing question, requires recursion [[ad hoc|implementation]]


# Explanation
---
recursively unpack the brackets and then process through the shuffles by [[parsing]] the text.

# Code
---
```c++

vector<int> oshuffle(vector<int> x)
{
	vector<int> out;
	for(int i = 0; i < ceil(x.size()/2); i++)
	{
		out.pb(x[i]);
		out.pb(x[i+ceil(x.size()/2)]);
	}
	return out;
}


vector<int> ishuffle(vector<int> x)
{
	vector<int> out;
	for(int i = 0; i < ceil(x.size()/2); i++)
	{
		out.pb(x[i+ceil(x.size()/2)]);
		out.pb(x[i]);
	}
	return out;
}

vector<int> bshuffle(vector<int> x)
{
	vector<int> out = x;
	out.erase(out.begin());
	out.pb(x[0]);
	return out;
}

string parse(string inp)
{
	string out = "";
	while(inp.length() > 0){
		// cout << "OUT:" << out << "   INP:" << inp << "\n";
		if(isdigit(inp[0]))
		{

			int count = inp[0] - '0';
			if(isalpha(inp[1])) // i.e no brackets
			{
				for(int i = 0; i < count; i++){
					out += inp[1];
				}
				inp.erase(0,2);
			}
			else{
							   
			string inside = "";
			int level = -1;
			for(int i = 2; i < inp.length(); i++) // level "(" to ")"
			{
				if(inp[i] == '(') level --;
				if(inp[i] == ')') level ++; 
				if(level == 0 and inp[i] == ')')
					break;
				inside += inp[i];
			}

			inp.erase(0,inside.length()+3); // 3 for the: number, (, and ) 

			for(int i = 0; i < count; i++)
				out += parse(inside);
			}		

		}
		else
		{
			out += inp[0];
			inp.erase(0,1);
		}
	}
	return out;
}

// shuffling 
void solve(int tc)
{
	vector<int> deck = {1,2,3,4,5,6,7,8};
	string s; cin >> s;
	string instructions = "";

	instructions = parse(s);
	// cout << instructions << "\n";
	for(auto i : instructions)
	{
		if(i=='i') 
		{
			deck = ishuffle(deck);
		}
		else if(i=='o')
		{
			deck = oshuffle(deck);
		}
		else if(i=='b')
		{
			deck = bshuffle(deck);
		}
	}

	for(auto i : deck)
	{
		cout << i << " ";
	}
	cout << "\n";
}


```