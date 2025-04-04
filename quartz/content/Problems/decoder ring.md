#bio
# decoder ring
---
> Quite an easy BIO 2018 Q2 compared to recent years [[ad hoc|implementation]]


# Explanation
---
This is another encryption problem, quite similar to the dials in [[turing machine]], yet more simplified with only 2 dials. 

# Code
---
```cpp

class DecoderRing {

	public:
		vector<char> dial1; 
		vector<char> dial2;
		string msg;

		DecoderRing(int n, string s){
			msg = s;

			// init dial 1
			for(char i = 'A'; i <= 'Z'; i++)
			{
				dial1.pb(i);
			}

			//init dial 2
			string letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			int idx = 0;
			while(letters.length())
			{
				int loc = (idx + n - 1) % letters.length();
				dial2.pb( letters[loc] );
				idx = loc;
				letters.erase( letters.begin() + loc );
			}
		}

		string encrypt(){
			string out = "";
			
			while(msg.length()){
				char cur = msg[0];
				msg.erase(msg.begin());

				int index = cur - 'A'; 
				
				char newchar = dial2[index];

				out += newchar;

				rotate();
			}
			return out;
		}

		void rotate()
		{
			char back = dial2.front();
			dial2.erase(dial2.begin());
			dial2.pb(back);
		}
};

void solve(int tc)
{
	int n; string s; 
	cin >> n >> s;
	DecoderRing ring(n,s);
	for(int i = 0; i < 6; i++)
	{
		cout << ring.dial2[i];
	}
	cout << "\n";
	cout << ring.encrypt() << "\n";

}


```