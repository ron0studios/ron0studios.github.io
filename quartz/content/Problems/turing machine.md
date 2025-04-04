#bio
# Turing machine
---
> BIO 2005 q2 which asks you to implement a turing machine [[ad hoc|implementation]]


# Explanation
---
this question was made much easier using structs instead of classes, unlike [[Enigma machine]] which uses a very similar type of structure

# Code
---
```cpp

// pairs for each of 0 and 1;
struct state{
	vector<int> w;
 	vector<int> dir;
 	vector<int>	t; 
};

void solve(int tc)
{
	int n; cin >> n;
	unordered_map<int,state> states; 
	map<char,int> dirs; 
	dirs['R'] = 1; dirs['L'] = -1; 

	for(int i = 0; i < n; i++)
	{
		string if0, if1; cin >> if0 >> if1; 
		state tmp; 
		tmp.w = {if0[0]-'0', if1[0]-'0'};
		tmp.dir = {dirs[if0[1]], dirs[if1[1]]};
		tmp.t = {if0[2]-'0', if1[2]-'0'};

		states[i+1] = tmp;
	}

	int iter; cin >> iter; 

	// simulate
	vector<int> tape(3000000,0); // arbitrary large number > 1 million
	int cur_state = 1;
	int cur_pos   = 1500000; // 3 mill / 2
	
	int its = 0;
	while(iter--)
	{
		int cell = tape[cur_pos];
		int w,dir,t; 
		w = states[cur_state].w[cell]; 
		dir = states[cur_state].dir[cell]; 
		t = states[cur_state].t[cell]; 

		tape[cur_pos] = w;
		cur_state = t;
		cur_pos += dir;

		its++;
		if(cur_state==0) break;
	}

	for(int i = -3; i < 4; i++)
	{
		cout << tape[cur_pos+i];
	}
	cout <<"\n" << its << "\n";

}


```