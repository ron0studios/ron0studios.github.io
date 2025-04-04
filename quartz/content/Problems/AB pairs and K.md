# AB pairs and K
---
> Not  a codeforces problem
> Given an integer K, how many possible pairs of A and B are there so that A & B = K (bitwise and)?  
> $0 \leq A,B \leq 2^{60}$

# Solution
This problem requires knowledge on [[Algorithms/bitwise operations]]
The technique is to solve for each bit independantly, since each bit is independant from one another in bitwise operations. 
Firstly take a look at this bit table for the **and** operation

| A   | B   | Result |
| --- | --- | ------ |
| 0   | 0   | 0      |
| 1   | 0   | 0      |
| 0   | 1   | 0      |
| 1   | 1   | 1      |

As you can see, if we take the bitset for K, and if a particular bit is 0, then there are only 3 combinations to make 0. Likewise there is only 1 way to make 1 (1 and 1), therefore every single A and B pair must contain 1's where there are 1's in K.

For example if K is equal to 3:

# Code
```c++
void solve(int tc)
{
	int k; cin >> k;
	bitset<60> K(k);
	long long output = 0;

	// solve individually for each bit
	// if n
	for(int i = 0; i < 4; i++){
		if(K[i]==0){
			output++;
		}
	}

	// 3 * 3 * 3 * 3..... N times
	cout << pow(3,output) << "\n";
}
```