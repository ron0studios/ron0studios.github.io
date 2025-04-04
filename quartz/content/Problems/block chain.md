#bio
# block chain
---
>[!summary] **very hard** BIO 2019 Q3


# Explanation
---
This is an extremely hard [[recursion]] problem, with a tiny bit of [[dynamic programming]] required.

As a naive solution you could use [[LCS]] combined with [[complete search#Recursively|brute forcing]] all the possible strings, but this will only yield you a maximum possible score of around 14/24.
A better solution still involves brute forcing, however, all arguments are just numbers, and computing LCS is not required at any point, which makes the function super fast.

ok so the abstraction required for this problem is to notice the fact that out of all the available moves we can make, if we make a move smaller than the smallest letter in our string, then we won't change the run-length at all, but if we make a move larger than our largest character, then we're guaranteed to make our run-length 1 character longer.

Consider also, the letters between the earliest consecutive letters in the string. To understand what is meant by this, take a look at the example of `16 NDL`, if we were to list out our available letters we'd get
$$
\text{\large a b c \huge D \large e f g h i j k \huge L \large m \huge N \large o p }
$$
with the small letters being the remaining letters which we can use. 

So the `DL` part of `NDL` means that there are 7 letters between `D` and `L` which are between those increasing parts of the sequence. 

Now all you have to do is recurse for each of, smaller, middle and larger ,to go through all the possibilities.

for example for the middle recursion, you do :
```cpp
for( int i = 0; i < middle; i++)
{
	tot += compute(length, smaller, i, larger+middle-i-1);
}
```
which is saying that you recurse to the same number of characters being smaller, the new middle ,and for the larger, since we've now set our new bracket from `DL` to whatever is at `i`, we have to add the `middle-i-1` to the larger set. 
If `i` was zero, and we used the same example as before, the string would technically be `NDLE` with the same length of 2.

Lastly we add some simple [[dynamic programming|dp]] to work for the larger test cases

# Code
---
```cpp


ll dp[20][20][20][20];
ll compute(int length, int smaller, int middle, int larger)
{
	if(dp[length][smaller][middle][larger] != -1) return dp[length][smaller][middle][larger];
	if(length >= 3) return 0;
	if(smaller + middle + larger == 0) return 1;

	ll tot = 0;
	if(length == 1)
	{
		for(int i = 0; i < smaller; i++)
		{
			tot += compute(length, i, middle, larger+smaller-i-1);
		}
	}
	else
	{
		for(int i = 0; i < smaller; i++)
		{
			tot += compute(length, i, middle+smaller-i-1, larger);
		}
	}

	for( int i = 0; i < middle; i++)
	{
		tot += compute(length, smaller, i, larger+middle-i-1);
	}

	for(int i = 0; i < larger; i++)
	{
		tot += compute(length+1, smaller,  middle+i, larger-i-1);
	}

	return dp[length][smaller][middle][larger] = tot;
}

void solve(int tc)
{
	memset(dp, -1, sizeof dp);
	int l;
	string pre;
	cin >> l >> pre;

	string remaining = "";
	for(int i = 0; i < l; i++)
	{
		if(find(pre.begin(), pre.end(), 'A'+i) == pre.end()) remaining += string(1, 'A'+i);
	}

	string seconds = "";
	for(int i = 0; i < pre.length(); i++)
	{
		for(int j = i+1; j < pre.length(); j++)
		{
			if(pre[j] > pre[i] and find(seconds.begin(), seconds.end(), pre[j]) == seconds.end())
				seconds += string(1, pre[j]);
		}
	}

	int length, smaller, middle, larger;
	length = 1;
	smaller = middle = larger = 0;

	// could use LCS but im lazy :/
	bool done = false;
	for(int i = 0; i < pre.length(); i++){
		for(int j = i+1; j < pre.length(); j++){
			for(int k = j+1; k < pre.length(); k++){
				if(pre[i] < pre[j] and pre[j] < pre[k])
				{
					cout << 0 << endl;
					return;
				}
				if(pre[i] < pre[j] or pre[j] < pre[k])
				{
					length = 2; 
					break;
				}
			}
			if(done) break;
		}
		if(done) break;
	}

	for(auto i : remaining)
	{
		if(i < *min_element(pre.begin(), pre.end()))
		{
			smaller++;
		}
		else if(seconds.length() and i < *min_element(seconds.begin(), seconds.end()))
		{
			middle++;
		}
		else
		{
			larger++;
		}
	}

	cout << compute(length, smaller, middle, larger);
}
```