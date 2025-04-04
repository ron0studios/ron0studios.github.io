# dolce vita
---
>[!summary] cool codeforces problem. a tiny bit [[maths|mathsy]], but mostly [[Greedy]]. what on earth does dolce vita mean? idk


# Explanation
---
this is a [[Greedy]] problem that also requires you to create a [[prefix sum]], atleast thats how i did it.

you first greedily sort the array from smallest to biggest. 
then, you create a [[prefix sum]] of the data.
then, you do the following:
- you create a variable 'out' = 0
- for each element in the prefix sum, you use the following expression to add to out: $$\Large{1 + \lfloor \frac{(x-b_i)}{i+1}\rfloor}$$
- if i =0, then you do $x-b_{0}+1$ instead

Why that formula?

its because for the first index, you'll have to go through $x-b_i$ cycles before you reach the budget $x$. However, later in the prefix sum, due to all the indices before it, the value actually increments by $i+1$, each time, since you include the increments before. 
Therefore to find the greedy number of purchases you can make at that index, you divide the $x-b_i$, over $x+1$, and floor it because you exclude any decimal points. 
You also add 1 as well, because you include the very first purchase too, at that point, if that makes any sense. 

This problem is a lot like [[removing smallest multiple]], and some prefix problems

# Code
---
```cpp
void solve(int tc)
{
	int n,x; cin >> n >> x;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];

	sort(a.begin(), a.end());
	if(a[0] > x) {
		cout << "0\n"; return;
	}

	vector<int> b(n,0);
	b[0] = a[0];
	for(int i = 1; i < n; i++)
	{
		b[i] = b[i-1] + a[i];
	}

	ll out = 0;
	for(int i = 0; i < n; i++)
	{
		if(i==0)
		{
			out += x-a[0]+1;
			continue;
		}
		if(b[i] > x) break;

		ll mult = i+1;
		out += 1+ floor( (x-b[i])/(float)mult );
	}

	cout << out << "\n";
}
```