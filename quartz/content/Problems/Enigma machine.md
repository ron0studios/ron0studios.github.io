#bio 
# Enigma machine
---
> A relatively difficult question 2 for the 2008 BIO


# Explanation
---
use classes and some double ended [[hash map|hash maps]]

# Code
---
```cpp

class Enigma {
	public:	
		map<char,char> rotor1;	
		map<char,char> rotor2;	
		map<char,char> rev_rotor1;	//reversed
		map<char,char> rev_rotor2;	//reversed
		map<char,char> reflector;	
		vector<char> letters = {'A','B','C','D'};
		int count = 0; // for rotations

		Enigma(ll init_n)
		{
			// init rotors
			rotor1['A'] = 'A';
			rotor1['B'] = 'D';
			rotor1['C'] = 'B';
			rotor1['D'] = 'C';
			rev_rotor1['A'] = 'A';
			rev_rotor1['B'] = 'C';
			rev_rotor1['C'] = 'D';
			rev_rotor1['D'] = 'B';


			rotor2['A'] = 'A';
			rotor2['B'] = 'C';
			rotor2['C'] = 'B';
			rotor2['D'] = 'D';
			rev_rotor2['A'] = 'A';
			rev_rotor2['B'] = 'C';
			rev_rotor2['C'] = 'B';
			rev_rotor2['D'] = 'D';


			reflector['A'] = 'D';
			reflector['B'] = 'C';
			reflector['C'] = 'B';
			reflector['D'] = 'A';

			if(init_n == 0)
				return;
			
			//encrypt(string(init_n,'A'));
			
			ll r1rots;
			ll r2rots;
			r1rots = init_n % 4;
			r2rots = (ll)(floor(init_n/4)) % 4;
			cout << r1rots << " " << r2rots << "\n";
			for(int i = 0; i < r1rots; i++)
				rotate1();
			for(int i = 0; i < r2rots; i++)
				rotate2();

			count = r1rots;
			
		}
		
		string encrypt(string s)
		{
			string out;
			for(auto i : s)
				out += mapletter(i);
			return out;
		}

		char mapletter(char inp)
		{
			char out;
			inp = rotor1[inp];
			inp = rotor2[inp];
			inp = reflector[inp];
			inp = rev_rotor2[inp];
			inp = rev_rotor1[inp];
			out = inp;
			count++;

			cout << count << "\n\n";
			rotate1();
			cout << "rot1\n";
			if(count % 4 == 0){
				rotate2();
				cout << "rot2\n";
			}
			cout << out << "\n";
			return out;
		}

		void rotate1()
		{
			map<char,char> tmp;
			map<char,char> rev_tmp;
			for(auto i : rotor1){
				int kval = ((i.first-'A')-1);
				int vval = ((i.second-'A')-1);
				if(kval < 0) kval = 3;
				if(vval < 0) vval = 3;
				char k = letters[kval],v = letters[vval]; 
				tmp[k] = v;
				rev_tmp[v] = k;
			}
			rotor1 = tmp;
			rev_rotor1 = rev_tmp;

		}

		void rotate2()
		{
			map<char,char> tmp;
			map<char,char> rev_tmp;
			for(auto i : rotor2){
				int kval = ((i.first-'A')-1);
				int vval = ((i.second-'A')-1);
				if(kval < 0) kval = 3;
				if(vval < 0) vval = 3;
				char k = letters[kval],v = letters[vval];
				tmp[k] = v;
				rev_tmp[v] = k;
			}
			rotor2 = tmp;
			rev_rotor2 = rev_tmp;
		}


};


void solve(int tc)
{
	ll n; cin >> n; 
	string s; cin >> s;
	Enigma machine(n);
	cout <<	machine.encrypt(s) << "\n";

}


```