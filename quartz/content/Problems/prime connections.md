#bio
# prime connections
---
> A pretty hard BIO 2016 Q3 with an interesting new algorithm

>[!warning] I haven't finished this yet! 

> [!update] I have now! :D, runs in 0.2 seconds!

# Explanation
---
You have to use an interesting algorithm known as [[Algorithms/bidirectional BFS]] in order to bring down computing time under a second. I have a regular BFS solution but it only runs at around 2 seconds when the time limit is 1.

> [!error] # BIG WARNING
>**ALWAYS** break out of a layer by *checking* the front of the queue instead of popping it!!!
>For example, you should do this:
>>[!success] good code
>```cpp
> 	if(q1.front().second != dist1)
> 	{
> 		dist1++;
> 		break;
> 	}
> 	pair<int,int> node = q1.front(); q1.pop();
>```
># AND NOT THIS
>> [!failure] bad code
>```cpp
> 	pair<int,int> node = q1.front(); q1.pop();
> 	if(node.second != dist1)
> 	{
> 		dist1++;
> 		break;
> 	}
>```

# Code
---
```cpp
int dp[16777217];
bool isPrime(int inp)
{
	if(dp[inp] != -1) return dp[inp];
	if(inp == 2) return true;
	if(inp == 1) return false;

	for(int i = 2; i <= ceil(sqrt(inp)); i++)
	{
		if(inp % i == 0)
		{
			dp[inp] = 0;
			return false;
		}
	}
	dp[inp] = 1;
	return true;
}

void solve(int tc)
{
	memset(dp, -1, sizeof dp);
	int l, p, q; cin >> l >> p >> q;
	int powlim = ceil(log2(l));

	queue<pair<int,int>> q1;
	vector<int> vis1(l+1,-1);
	int dist1 = 0; 
	q1.push(mp(p,0));
	vis1[p] = 0;

	queue<pair<int,int>> q2;
	vector<int> vis2(l+1,-1);
	int dist2 = 0; 
	q2.push(mp(q,0));
	vis2[q] = 0;

	bool which = true;
	while(true)
	{
		while(true)
		{
			if(which)
			{
				if(q1.empty()){
					break;
				}
				if(q1.front().second != dist1)
				{
					dist1++;
					break;
				}
				pair<int,int> node = q1.front(); q1.pop();


				int i = 1;
				while(i <= pow(2, powlim))
				{
					if(node.first+i > l and node.first-i < 0) break;

					if(node.first+i <= l and vis1[node.first+i] == -1){
						if(isPrime(node.first+i)) {
							vis1[node.first+i] = node.second+1;
							q1.push(mp(node.first+i, node.second+1));
						}
					}
					if(node.first-i > 1 and vis1[node.first-i] == -1){
						if(isPrime(node.first-i)) {
							vis1[node.first-i] = node.second+1;
							q1.push(mp(node.first-i, node.second+1));
						}
					}
					i *= 2;
				}

			}
			else
			{
				if(q2.empty()) {
					break;
				}
				if(q2.front().second != dist2)
				{
					dist2++;
					break;
				}
				pair<int,int> node = q2.front(); q2.pop();


				int i = 1;
				while(i <= pow(2, powlim))
				{
					if(node.first+i > l and node.first-i < 0) break;

					if(node.first+i <= l and vis2[node.first+i] == -1){
						if(isPrime(node.first+i)) {
							vis2[node.first+i] = node.second+1;
							q2.push(mp(node.first+i, node.second+1));
						}
					}
					if(node.first-i > 1 and vis2[node.first-i] == -1){
						if(isPrime(node.first-i)) {
							vis2[node.first-i] = node.second+1;
							q2.push(mp(node.first-i, node.second+1));
						}
					}
					i *= 2;
				}
			}

		}


		bool brk = false;
		for(int i = 1; i <= l; i++)
		{
			if(vis1[i] != -1 and vis2[i] != -1)
			{
				cout << vis1[i] + vis2[i] + 1 << endl;
				brk = true;
				break;
			}
		}
		if(brk) break;

		if(q1.empty() and q2.empty()) break;

		which = !which;
	}

}
```


> [!info]- old code
> ```cpp
> 
> bool isprime(int x)
> {
> 	for(int i = 2; i <= sqrt(x); i++)
> 	{
> 		if(x % i == 0) return false;
> 	}
> 	return true;
> }
> 
> int shortest_path(int from, int to, int l){
> 	int maxpower = ceil(log2(l));
> 	//cout << maxpower << "\n";
> 
> 	unordered_map<int,bool> visitedA; 
> 	unordered_map<int,bool> visitedB; 
> 	visitedA[from] = true;
> 	visitedB[to] = true;
> 	queue<pair<int,int>> qA; 
> 	queue<pair<int,int>> qB; 
> 	
> 
> 	unordered_map<int,int> depthA; depthA[from] = 1;
> 	unordered_map<int,int> depthB; depthB[to] = 1;
> 
> 	qA.push(mp(from,1));
> 	qB.push(mp(to,1));
> 	while(true)
> 	{
> 		pair<int,int> nodeA = qA.front(); qA.pop();
> 		//pair<int,int> nodeB = qB.front(); qB.pop();
> 		depthA[nodeA.first] = nodeA.second;
> 		//depthA[nodeB.first] = nodeB.second;
> 
> 		/*
> 		cout << nodeA.first << "\t" << nodeA.second << "\n";
> 		cout << nodeB.first << "\t" << nodeB.second << "\n";
> 		cout << "\n";
> 		*/
> 
> 		if(nodeA.first == to)
> 			return nodeA.second;
> 
> 		for(int i = 0; i <= maxpower; i++)
> 		{
> 			int negA, negB, posA, posB;
> 			negA = nodeA.first - pow(2,i);
> 			posA = nodeA.first + pow(2,i);
> 			//negB = nodeB.first - pow(2,i);
> 			//posB = nodeB.first + pow(2,i);
> 
> 			if(!visitedA[negA] and negA > 1 and isprime(negA)){
> 				visitedA[negA] = true;
> 				qA.push(mp(negA,nodeA.second+1));
> 			}
> 			if(!visitedA[posA] and posA <= l and isprime(posA)){
> 				visitedA[posA] = true;
> 				qA.push(mp(posA,nodeA.second+1));
> 			}
> 
> 			//if(!visitedB[negB] and negB > 1 and isprime(negB)){
> 			//	visitedB[negB] = true;
> 			//	qB.push(mp(negB,nodeB.second+1));
> 			//}
> 			//if(!visitedB[posB] and posB <= l and isprime(posB)){
> 			//	visitedB[posB] = true;
> 			//	qB.push(mp(posB,nodeB.second+1));
> 			//}
> 		}
> 	}
> }
> 
> void solve(int tc)
> {
> 	int l,p,q; cin >> l >> p >> q;
> 	
> 	int out = shortest_path(p,q,l);
> 	cout << out << "\n";
> }
> 
> 
> ```