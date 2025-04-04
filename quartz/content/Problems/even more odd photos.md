# even more odd photos
---
>[!summary] A good usaco bronze problem 2


# Explanation
---
In this question you are asked to convert a sequence of numbers into the largest possible set of groups such that the groups can be placed side-by-side with the sum of each group alternating between even and odd.

This is a [[Greedy]] problem, since we are asked to find the **largest possible set**, meaning this requires optimisation, which can be solved^[usually] greedily. 

First recall the following rules:
- $even + even = even$
- $even + odd = odd$
- $odd + odd = even$

Consider the best case scenario for this problem, which is when all of the group sizes are of length 1, i.e we are able to just pick out a sequence of alternating even and odd numbers. This is usually possible in two scenarios:
- When $E=O$ (e.g `2 1 2 1`)
- When $E=O+1$ (e.g `2 1 2`)

If we have too many evens, i.e $E > O+1$, then we need to reduce the number of even numbers. What we can do is group together two even numbers together. Recall that two evens make an even, so what we have essentially done is going from this:
$$
E,E,E,O
$$
to this:
$$
(E,E),E,O
$$
which is the same as saying:
$$
E,E,O
$$
Now, one of the conditions are met^[$E=O+1$], meaning that we are able to now create an alternating sequence, which is `E O E`, where one of the E's actually refers to `E,E`. So we have made a sequence using 3 groups. 


Now consider what happens when we have too many odds, i.e $E < O$ . In this case we need to reduce the number of odds. What we can do is group together two odd numbers. Recall that two odds make an even, so when we group together two odds, we have reduced the number of odds in the sequence by two and added an even number, effectively going grom this:
$$
O, O, O, E
$$
to this:
$$
(O,O),O,E
$$
which is the same as saying:
$$
E,O,E
$$
Now we can do the same as before.


# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	int o = 0; 
	int e = 0;
	for(int i = 0; i < n; i++){
		int x; cin >> x;
		if(x%2 == 1) o++; else e++;
	}

	int out = 0;


	while(e > o+1 or e < o){

		//cout << e << " " << o << endl;
		if(e > o+1)
		{
			e -= 1;
			out++;
		}
		if(e < o)
		{
			o -= 2;
			e += 1;
			out++;
		}
	}

	//out += e+o;

	cout << e+o;

}
```