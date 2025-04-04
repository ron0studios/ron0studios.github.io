# build permutation
---
>[!summary] codeforces problem


# Explanation
---
A [[recursion|recursive]] [[maths]] problem which requires you to look at the examples carefully. 
Take a look at the answers for the first 7 numbers for $n$ 
$$
\LARGE{
\cases{
1:&[0], \\
2:&[1,0], \\
3:&[1,0,2], \\
4:&[0,3,2,1], \\
5:&[4,3,2,1,0], \\
6:&[0,3,2,1,5,4], \\
7:&[1,0,2,6,5,4,3]
}}
$$
Can you notice the decrementing sequences in each of the cases? Take a look at `6,5,4,3` or `4,3,2,1,0`.
If you take a look at a number thats already a *perfect square*, you can see that **the entire permutation** is just a decrementing sequence.

So if you find the number that makes an index equal to a perfect square, then you can immediately fill in the numbers to the left incrementally. Then you recursively do the same for the suffix after that.

So if you 

<iframe title="Build Permutation || Codeforces Round 812 Div2 Problem C" src="https://www.youtube.com/embed/cqFE-V72eAI?feature=oembed" height="113" width="200" allowfullscreen="" allow="fullscreen" style="aspect-ratio: 1.76991 / 1; width: 100%; height: 100%;"></iframe>

# Code
---
```cpp

vector<pair<int,int>> out;

void compute(int x)
{
	if(x<=0) return;
	int match = -1;
	for(int j = 0; j < 450; j++)
		if((j*j)>=(x-1)){
			match = j*j;
			break;
		}

	out.pb( mp(x-(match-(x-1)), match-(x-1)) );

	compute(match-(x-1));
}

void solve(int tc)
{
	int n; cin >> n;
	out = vector<pair<int,int>>();

	compute(n);

	for(int i = (int)out.size()-1; i >= 0; i--)
	{
		int start = out[i].second;
		for(int j = out[i].first-1; j >= 0; j--)
			cout << start+j << " ";
	}
	cout << "\n";
}


```