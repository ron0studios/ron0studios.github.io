#bio
# alpha complex
---
> A quite difficult BIO 2020 Q2 [[ad hoc|implementation]]


# Explanation
---
This problem requires knowledge on [[graph]] representation. Due to the exits being relative to each node (i.e a->B is a different exit to b->A), a [[graph#Node list|Node list]] approach was far better suited. 

# Code
---
```cpp

class AlphaComplex {
	public:
		int p,q;
		char pos = 'A';
		int num_letters;

		map<char,vector<pair<char,int>>> graph;
		unordered_map<char,int> visits; 

		AlphaComplex(string a, int b, int c) {

			/*graph['X'] = {{'B',0},{'I',0},{'O',0}};
			graph['B'] = {{'X',0}};
			graph['I'] = {{'X',0}};
			graph['O'] = {{'X',0}};
			for(auto i : "XBIO")
				visits[i] = 0;

			p = b; q = c;
			printGraph();
			return;*/

			// convert plan to graph;
			num_letters = a.length()+2;

			unordered_map<char,bool> chosen;
			while(a.length())
			{
				char poll = a[0];
				char to;
				for(char i = 'A'; i < 'A'+num_letters; i++)
				{
					if(count(a.begin(),a.end(),i)==0 and !chosen.count(i)) {
						to = i; 
						chosen[i] = true;
						break;
					}
				}
				a.erase(a.begin());
				graph[poll].pb(mp(to,0));
				graph[to].pb(mp(poll,0));
			}

			// connect leftover two
			vector<char> leftover;
			while(chosen.size() != num_letters){
				for(char i = 'A'; i < 'A'+num_letters; i++)
				{ 
					if(!chosen.count(i))
					{
						leftover.pb(i);
						chosen[i] = true;
					}
				}
			}
			graph[leftover[0]].pb(mp(leftover[1],0));
			graph[leftover[1]].pb(mp(leftover[0],0));

			
			for(char i = 'A'; i < 'A'+num_letters; i++)
			{
				sort(graph[i].begin(),graph[i].end());
				for(auto j : graph[i])
				{
					cout << j.first << " ";
				}
				cout << "\n";
			}
			


			for(char i = 'A'; i < 'A'+num_letters; i++)
			{
				visits[i] = 0;
			}
			//visits['A'] = 1;


			p = b;
			q = c;

			//printGraph();
		}


		void run(){
		}

		void step(){
			//cout << pos << "\n";
			char next;
			visits[pos] ++;

			if(visits[pos] % 2 == 1)
			{
				//cout << 1 << "\n";
				next = graph[pos][0].first;
				graph[pos][0].second++;
			}
			else
			{
				for(int i = 0; i < graph[pos].size(); i++)
				{
					if(graph[pos][i].second % 2 == 1)
					{
						if(i == graph[pos].size()-1) // the end;
						{

							//cout << 2.1 << "\n";
							next = graph[pos][i].first;
							graph[pos][i].second++;
							
						}
						else
						{
							//cout << 2.2 << "\n";
							next = graph[pos][i+1].first;
							graph[pos][i+1].second++;
						}
						break;
					}
				}
			}

			pos = next;
			//cout << "\n";
		}


		void printGraph()
		{
			for(auto i : graph)
			{
				cout << i.first << " ::: ";
				for(auto j : i.second)
				{
					cout << j.first << " ";
				}
				cout << "\n";
			}
			cout << "\n\n";
			cout << flush;
		}


};

void solve(int tc)
{
	string plan;
	int p, q;
	cin >> plan >> p >> q;
	AlphaComplex x(plan,p,q);


	auto start = chrono::high_resolution_clock::now();
	for(int i = 1; i <= q; i++)
	{
		x.step();
		if(i==p) 
			cout << x.pos;
		if(i==q)
			cout << x.pos;
	}

	auto stop = chrono::high_resolution_clock::now();
	auto duration = chrono::duration_cast<chrono::microseconds>(stop - start);
	cout << "\nTime taken by function: "
         << duration.count()/1000000.0f << " seconds" << endl;

	cout << "\n\n\n";
}
```