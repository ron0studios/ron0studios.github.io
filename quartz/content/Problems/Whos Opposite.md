
# Who's Opposite? 
https://codeforces.com/contest/1560/problem/B
#math

>
Some number of people (this number is even) have stood in a circle. The people stand in the circle evenly. They are numbered clockwise starting from a person with the number 1. Each person is looking through the circle's center at the opposite person.
![](https://espresso.codeforces.com/1e852acca4931efe879bdd2d987eb30d481871c0.png)
>
You don't know the exact number of people standing in the circle (but this number is even, no doubt). It is known that the person with the number a is looking at the person with the number b (and vice versa, of course). What is the number associated with a person being looked at by the person with the number c? If, for the specified a, b, and c, no such circle exists, output -1.
>
Input
The first line contains one integer t (1≤t≤104) — the number of test cases. Then t test cases follow.
>
Each test case consists of one line containing three distinct integers a, b, c (1≤a,b,c≤108).
>
Output
For each test case output in a separate line a single integer d — the number of the person being looked at by the person with the number c in a circle such that the person with the number a is looking at the person with the number b. If there are multiple solutions, print any of them. Output −1 if there's no circle meeting the given conditions.


## Answer
Since the quesion already assumes that the number in the circle is even, we can say that there will be the same amount of nodes above and below the A and B pair. Therefore, the total number in the circle should be the difference between A and B (the distance clockwise required to get from A to B) multiplied by 2, plus 2 (because we have to include A and B as well). 
We can find the opposite of any number by incrementing the same difference between A and B, since those are opposites. Or you could just increment it by half of the total.
To find out invalid results, there are 2 cases:
- the number is greater than the total itself (e.g 1 3 and 5)
- Either A or B are greater than the total (e.g 3 and 4)

## Code
```c++
void solve(int tc)
{
	long long a,b,c; cin >> a >> b >> c;
	long long total; 
	long long diff = (max(a,b) - min(a,b));
	total = (max(a,b)-min(a,b)-1)*2; total += 2;
	
	if( c > total  || a > total || b > total)
	{
		cout << -1 << "\n"; return;
	}
	cout << ( (c-diff<1) ? c+diff : c-diff ) << "\n";

}
```