# restore the array
---
>[!summary] An annoying codeforces problem


# Explanation
---
This was a simple to implement, but hard to understand [[Greedy]] [[maths]] problem. 

The solution is really simple, all you have to do is follow this formula for every item in the new array:
$$
\Large{
b[i+1] = min(a[i],a[i+1])
}
$$
where $b[0] = a[0]\text{, and  } b[n] = a[n-1]$

Now, big question, **why?**

Let's look at two cases, one where numbers are increasing, and another where the numbers are decreasing.

## case 1: increasing numbers 

Let's look at the example $$\Large{a=[3,4,5,6]}$$
Now, let's first set the first and last element of the table as $b = [3,....,6]$ .  So, now we need to find out what $b[1]$ should be. First, we know that $b[1]$ effects $a[0]$ and $a[1]$^[because $a[0]$ is made from $b[0]$ and $b[1]$, and $a[1]$ is made from $b[1]$ and $b[2]$. See how $b[1]$ is common between the two?].

Also, we know that since $a[1] > a[0]$, the second element needs to be removed from the first two elements of $b$, to allow the $3$ to be placed as the first element. Of the two positions in $b$ that $a[1]$ depends on, $b[2]$ is the better one to allow $a[0]$ to be placed.

## case 2: decreasing numbers

Let's look at the example $$\Large{a=[6,5,4,3]}$$

Now, let's first set the first and last element of the table as $b = [6,....,3]$ .  So, now we need to find out what $b[1]$ should be. First, we know that $b[1]$ effects $a[0]$ and $a[1]$. 

Also we know that since $a[1] < a[0]$, the 2nd element can stay where it is in the first 2 elements of $b$, since $a[0]$ will be picked regardless. Of the two positions in $b$ that $a[1]$ depend on, it is best to [[Greedy|greedily]] put it in $b[1]$, so that we have space later on to fit the other numbers. 



> [!warning] :(
> I couldnt figure out this problem and it lead me to flopping the div3 round for it

# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<int> b(n,0);
	vector<int> a(n-1,0);
	for(int i = 0; i < n-1; i++)
		cin >> a[i];

	b[0] = a[0];
	b[n-1] = a[n-2];

	for(int i = 0; i < n-2; i++)
	{
		b[i+1] = min(a[i], a[i+1]);
	}
	
	for(auto i : b)
		cout << i << " ";
	cout << endl;
}
```
