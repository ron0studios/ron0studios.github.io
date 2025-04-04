#bio
# number ladders
---
>[!summary] BIO 2012 hard problem




# Explanation
---
This is a very hard problem which requires good knowledge on [[bidirectional BFS]], which is the only option to speed up this program to under 5 seconds^[apart from just straight up brute forcing the paths and copying/pasting it into the code, which tmncollins did...].

You do Bi-BFS on each layer one by one from source to sink and try to find a match. 

see [[prime connections]] for a similar problem

# Code
---
```cpp


int dist(string a, string b)
{
	unordered_map<char,int> count;
	for(auto c : a)
		count[c]++;
	for(auto c : b)
		count[c]--;

	int out = 0;
	for(auto i : count)
		out += abs(i.second);

	return out;
}


vector<string> digits = {"ZERO","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE"};

string todig(string inp)
{
	string out = "";
	for(auto x : inp)
	{
		out += digits[x-'0'];
	}
	//sort(out.begin(),out.end());
	return out;
}


void solve(int tc)
{
	string a, b; cin >> a >> b;

	queue<pair<string,int>> q1; 
	vector<int> vis1(1000, -1);
	int dist1 = 0;
	q1.push(mp(a,0));
	vis1[stoi(a)] = 0;

	queue<pair<string,int>> q2; 
	vector<int> vis2(1000, -1);
	int dist2 = 0;
	q2.push(mp(b,0));
	vis2[stoi(b)] = 0;

	bool which = true;
	while(true)
	{
		//cout << "yeah" << endl;
		
		// do one layer
		while(true)
		{
			if(which) // q1
			{
				pair<string, int> node = q1.front(); q1.pop();
				string digstr = todig(node.first);

				if(node.second != dist1)
				{
					dist1++;
					break;
				}

				for(int i = 1; i <= 999; i++)
				{
					if(i == stoi(node.first)) continue;
					if(vis1[i] != -1) continue;
					if(dist(digstr, todig(to_string(i)) ) > 5) continue;

					vis1[i] = node.second+1;
					q1.push( mp(to_string(i), node.second+1));
				}

			}
			else
			{
				pair<string, int> node = q2.front(); q2.pop();
				string digstr = todig(node.first);

				if(node.second != dist2)
				{
					dist2++;
					break;
				}

				for(int i = 1; i <= 999; i++)
				{
					if(i == stoi(node.first)) continue;
					if(vis2[i] != -1) continue;
					if(dist(digstr, todig(to_string(i)) ) > 5) continue;
					
					vis2[i] = node.second+1;
					q2.push( mp(to_string(i), node.second+1));
				}

			}
		}

		bool brk = false;
		// check match
		for(int i = 1; i <= 999; i++)
		{
			if(vis1[i] != -1 and vis2[i] != -1)
			{
				cout << "YEAH\n";
				cout << vis1[i] << " " << vis2[i] << endl;
				brk = true;
				break;
			}
		}
		if(brk) break;
		// which = !which;
	}
}
```









>[!info]- alternative [[Greedy]] approach
>
> # Explanation
> ---
> > [!warning]
> > this only gets 20/23
> 
> you need [[bidirectional BFS]] to solve this
> 
> # Code
> ---
> 
> 
> 
>
> ```cpp
>  int dist(string a, string b)
>  {
> 	vector<vector<int>> dp(a.length()+1, vector<int>(b.length()+1,0));
>  
>  	dp[0][0] = 0;
>  	for(int i = 1; i <= (int)a.length(); i++)
>  		dp[i][0] = i;
>  	for(int i = 1; i <= (int)b.length(); i++)
>  		dp[0][i] = i;
>  
>  	for(int i = 1; i <= (int)a.length(); i++)
>  	{
>  		for(int j = 1; j <= (int)b.length(); j++)
>  		{
>  			if(a[i-1] == b[j-1]){
>  				dp[i][j] = dp[i-1][j-1];
>  				continue;
>  			}
>  
>  			dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + 1;
>  		}
>  	}
>  
>  	
>  	/*
>  	for(int i = 0; i <= a.length(); i++)
>  	{
>  		for(int j = 0; j <= b.length(); j++)
>  		{
>  			cout << dp[i][j] << " " ;
>  		}
>  		cout << endl;
>  	}
>  	*/
>  	
>  
>  	return dp.back().back();
>  }
>  
>  
>  vector<string> digits = {"ZERO","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE"};
>  
>  string todig(string inp)
>  {
>  	string out = "";
>  	for(auto x : inp)
>  	{
>  		out += digits[x-'0'];
>  	}
>  	sort(out.begin(),out.end());
>  	return out;
>  }
>  
>  void solve()
>  {
>  	for(int num = 0; num < 3; num++){
>  		string a,b; cin >> a >> b;
>  		a = todig(a);
>  		b = todig(b);
>  
>  
>  		int out = 1; 
>  		while(true)
>  		{
>  			//cout << a << " " << b << endl;
>  			if(dist(a,b) <= 5)
>  			{
>  				break;
>  			}
>  
>  			string minstr;
>  			int minb = INT_MAX;
>  			for(int i = 1; i <= 999; i++)
>  			{
>  				string n = todig(to_string(i));
>  				int a2n = dist(a, n);
>  				int n2b = dist(n, b);
>  				//cout << a2n << " " << n2b << endl;
>  				//usleep(100000);
>  				if(a2n <= 5)
>  				{ 
>  					if(n2b < minb) 
>  					{
>  						minb = n2b;
>  						minstr = n;
>  					}
>  				}
>  			}
>  			a = minstr;
>  			out++;
>  		}
>  		cout << out << endl;
>  	}
>  	cout << endl;
>  
>  }
> ```
> 