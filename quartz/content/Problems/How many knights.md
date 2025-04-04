# How many knights
---
>[!summary] UVA 696. A pretty easy problem for large test cases, just a bit finicky for the weirder small value test cases. Took 30 mins to an hour.


# Explanation
---
This [[ad hoc]] problem, on the larger test cases (n,m > 4) is a subset of the **UVA [[Chess]]** problem, tackling specifically the cases for knights. Referring to my notes on that problem [[Chess#knights|here]], all you have to do is use the formula $\frac{mn}{2}$ to get the answer for cases where $m>2 \cap n>2$. 
However for cases smaller than this, we need to place the knights differently. Specifically this pattern in the case of a 2 row 8 column board....
![[image-20240811110050765.png|-left]]

The switch statement in my code deals with this, solving edge cases, for example if the number of columns was 5, meaning the max number of knights is 6 instead of 8. 
# Code
---
```cpp
void solve(int a, int b)
{
	int out = max(4,(int)ceil((a*b)/2.0));
	if(a < 2 or b < 2) out = a*b;
	else if(a!=b and (a==2 or b==2)){
		//out = (((a*b)/5)+1)/2*4;
		int len = max(a,b);
		switch(len % 4)
		{
			case 0:
				out = len;
				break;
			case 1:
				out = len+1;
				break;
			case 2:
				out = len+2;
				break;
			case 3:
				out = len+1;
				break;
		}
	}
	cout << out << " knights may be placed on a " << a << " row " << b << " column board." <<  endl;
}
```