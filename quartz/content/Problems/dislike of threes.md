# CF 1560A - dislike of threes
https://codeforces.com/contest/1560/problem/A
[[maths]]
>
Polycarp doesn't like integers that are divisible by 3 or end with the digit 3 in their decimal representation. Integers that meet both conditions are disliked by Polycarp, too.
>
Polycarp starts to write out the positive (greater than 0) integers which he likes: *1,2,4,5,7,8,10,11,14,16,…*. Output the k-th element of this sequence (the elements are numbered from 1).
>
**Input**
The first line contains one integer t (1≤t≤100) — the number of test cases. Then t test cases follow.
>
Each test case consists of one line containing one integer k *(1≤k≤1000)*.
>
**Output**
For each test case, output in a separate line one integer x — the k-th element of the sequence that was written out by Polycarp.


## Answer
Like an Nth term sequence, start iterating from 1 to a, where x will be the latest value in the sequence, whilst c is an arbritrary counter. aa
In the while loop, if there is a 3 at the end of C, or if its divisible by 3, then we increment C, but increase A, like the loop never happened in the first place. There are many ways of doing this, such as a while loop in a while loop. 
If C is a valid part of the sequence, we set X to be C, and increment C as usual without resetting A.
## Code
```c++
void solve(int tc)
{
	int a; cin >>a ;
	string x = "1";
	int c = 1;
	while(a--)
	{
		if(to_string(c).back() == '3')
		{
			c++; a++;
		}
		else if( float(c)/3 == round(float(c)/3))
		{
			c++; a++;
		}
		else
		{
			x = to_string(c);
			c++;
		}
	}
	cout << x << "\n";
}
```

