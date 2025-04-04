# splitting numbers
---
>[!summary] UVA 11933. Simple [[bitwise operations]] problem. Took around 10 mins


# Explanation
---
Just need to loop through the int bitsize, 32, and maintain a `flip` to alternate between odd-occurring 1s and even occurring 1s.
# Code
---
```cpp
void solve(int n)
{
	bool flip = 0;
	int a=0, b=0;
	for(int i = 0; i < 32; i++){
		if(n>>i&1){
			a |= (!flip<<i);
			b |= (flip<<i);
			flip=!flip;
		} 
	}
	cout << a << " " << b << endl;

}
```