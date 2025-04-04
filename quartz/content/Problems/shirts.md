#bio 
# Shirts
---
> A medium-ish difficulty 2008 Question 3


# Explanation
---
This is an interesting question that doesn't require recursion, but a twist on the [[BFS]] algorithm to explore all layers of a [[complete search]] tree. 

# Code
---
```cpp

string a(string inp)
{
	string out;
	out += inp.substr(1,3);
	out += inp[0];
	out += inp.substr(4,3);
	return out;
}

string b(string inp)
{
	string out;
	out += inp.substr(0,3);
	out += inp[6];
	out += inp.substr(3,3);
	return out;
}

string c(string inp)
{
	string out;
	out += inp[3];
	out += inp.substr(0,3);
	out += inp.substr(4,3);
	return out;
}

string d(string inp)
{
	string out;
	out += inp.substr(0,3);
	out += inp.substr(4,3);
	out += inp[3];
	return out;
}


int shirts(string order, int depth=0)
{
	// BFS
	
	queue<pair<string,int>> q; 
	unordered_map<string,bool> visited;
	visited[order] = true;
	q.push(mp(order,0));
	while(!q.empty())
	{
		auto item = q.front(); q.pop();
		if(item.first == "1234567"){
			return item.second;
		}

		if(!visited[a(item.first)]){
			visited[a(item.first)] = true;
			q.push(mp(a(item.first),item.second+1));
		}

		if(!visited[b(item.first)]){
			visited[b(item.first)] = true;
			q.push(mp(b(item.first),item.second+1));
		}

		if(!visited[c(item.first)]){
			visited[c(item.first)] = true;
			q.push(mp(c(item.first),item.second+1));
		}

		if(!visited[d(item.first)]){
			visited[d(item.first)] = true;
			q.push(mp(d(item.first),item.second+1));
		}
	}
}

void solve(int tc)
{
	string s; cin >> s;
	cout << shirts(s);
}
```