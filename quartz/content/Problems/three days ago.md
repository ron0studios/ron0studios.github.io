# three days ago
---
>[!summary] A fun atcoder problem


# Explanation
---
This problem requires [[dynamic programming]] and some [[bitwise operations]] knowledge. 

Firstly, notice that a string of numbers can be made into two identical groups only if the count of each number in the string is even^[how else can we have the same number of each in both groups then?]. 

Alright, now let's say at a given index $i$, the count of a certain digit is $x$ ($1 \leq x \leq 9$). If $x$ is even, then we'll say the value at that index is 1, and 0 if odd. 

Let's do that for every digit in the example given in atcoder, `20230322`

| X | 2   | 0   | 2   | 3   | 0   | 3   | 2   | 2   |
| - | --- | --- | --- | --- | --- | --- | --- | --- |
| **0** | 1   | 0   | 0   | 0   | 1   | 1   | 1   | 1   |
| **2** | 0   | 0   | 1   | 1   | 1   | 1   | 0   | 1   |
| **3** | 1   | 1   | 1   | 0   | 0   | 1   | 1   | 1   |

Here are all the pairs (l,r) for this problem:
- (1,6)
- (1,8)
- (2,7)
- (7,8)

For each of these pairs, the binary pattern in the column is the same. For example in (7,8), the binary pattern at 6 (111) is the same as the one at 8 (111)

>[!note]
>when $L$ equals 1, we'll use a default value of (111...111), because if we had nothing, we can create two pile of nothing, so everything defaults to 1, (even)

So all we have to do now is find pairs where the "state" of the binary numbers are the same. 

We can do this by saving these binary numbers as integers in an array and using bit operations, such as XOR to change them. Note that whenever we introduce a new number we're going to be flipping the bit of the associated number in the binary pattern, because things flip from even to odd.

We count the number of occurences of each pattern and use the summation formula to find the number of pairs you can make from it 
$$
\Large{
S_{n} = \frac{n(n-1)}{2}
}
$$
This is a pretty similar prefixing problem to 

# Code
---
```cpp

void solve()
{
	string s; cin >> s;
	deque<int> states;

	for(int i = 0; i < s.length(); i++)
	{
		int prevstate = 2047;
		if(i>0)
			prevstate = states.back();

		int cur = s[i]-'0';
		prevstate = prevstate ^ (1 << cur);
		states.pb(prevstate);
	}

	states.push_front(2047);
	vector<ll> cnt(2048,0);
	ll out = 0;

	for(int i = 0; i < (int)states.size(); i++)
	{
		cnt[states[i]]++;
	}


	for(int i = 0; i <= 2047; i++)
	{
		out += (cnt[i]*(cnt[i]-1))/ 2;
	}


	cout << out;
}


```