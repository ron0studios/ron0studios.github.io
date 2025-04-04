#bio
# Coloured Triangles
---
> Problem A for the british informatics olympiad (BIO) round 1 2017.
> Given a string of numbers complete the pyramid, and return the **resultant letter** at the very top.
> The rules of the pyramid are simple, if the two letters above a letter in the pyramid are the same, then the letter remains the same. The 3 possible letters are **R, G and B**, meaning that if the above two letters in the pyramid are different, the resultant letter in that spot will be the remaining 3rd letter^[the problem would not work otherwise, since there will be more states to consider].
> Example:
> INPUT: **RGBGR** OUTPUT = **B**
> Why? 
> R G B G R
> B R R B
> G R G
> B B
> B

# Explanation
---
This is a relatively simple simulation problem. I just have a relatively sloppy method for finding out the remaining letter if the other 2 are present. With the python solution, I managed to make some really neat colour descriptions to see some of the nice patterns!

![[Pasted image 20211127002411.png]]
The image above shows the pattern when a single different letter is sandwiched between a pair of length 10 strings of identical letters 

![[Pasted image 20211127002802.png]]
Here's a way bigger one! This one looks especially chaotic.

![[Pasted image 20211127003845.png]]
Here is the same one but with block colouring, look at the emerging patterns.

![[Pasted image 20211127004102.png]]
Can you see a pattern here? it looks a [[sierpinski's triangle]].  There seems to be a prevevalant link between this and sierpinski's triangle. I will need to find out why this is ( #tofinish  ). 
Here are some intersections between two sources to show some of the caused chaos when two sierpinski's triangles meet.
![[Pasted image 20211127004617.png]]

# Code
--- 
## Python code
```python
s = input().strip()
tmp = ""
spaces = 0

# decorate string (with colours)
def strdecor(s):
    x = list(s)
    for i in range(len(x)):
        if x[i] == "R":
            x[i] = "\u001b[31mR \u001b[0m"
        elif x[i] == "G":
            x[i] = "\u001b[32mG \u001b[0m"
        elif x[i] == "B":
            x[i] = "\u001b[36mB \u001b[0m"
    return "".join(x)

print(strdecor(s))

while len(s) > 1:
    spaces += 1
    for i in range(1,len(s)):
        if s[i] == s[i-1]:
            tmp += s[i]
        else:
            rinc = False
            ginc = False
            binc = False
            if s[i] == 'R' or s[i-1] == 'R':
                rinc = True
            if s[i] == 'G' or s[i-1] == 'G':
                ginc = True
            if s[i] == 'B' or s[i-1] == 'B':
                binc = True
                
            if rinc == False:
                tmp += 'R'
            elif ginc == False:
                tmp += 'G'
            else:
                tmp += 'B'
    s = tmp
    tmp = ""
    
    print(" "*spaces+strdecor(s))

```

## C++ code
---
```c++
void solve(int tc)
{
	string s; cin >> s;
	string tmp = "";
	

	for(auto i : s)
	{
		cout << i << " ";
	}
	cout << "\n";
	int spaces = 0;

	while(s.length() > 1) {
		spaces++;
	for( int i = 1; i < s.length(); i++)
	{
		if(s[i] == s[i-1])
		{
			tmp += s[i];
		}
		else
		{
			bool rinc = false; // red included
			bool ginc = false; // green included
			bool binc = false; // blue included

			if(s[i] == 'R' || s[i-1] == 'R')
				rinc = true;
			if(s[i] == 'G' || s[i-1] == 'G')
				ginc = true;
			if(s[i] == 'B' || s[i-1] == 'B')
				binc = true;

			if(rinc == false)
				tmp += 'R';
			else if(ginc == false)
				tmp += 'G';
			else if(binc == false)
				tmp += 'B';
		}
	}

		s = tmp;
		tmp = "";
		cout << string(spaces, ' ');
		for(auto i : s)
		{
			cout << i << " ";
		}
		cout << "\n";
}
}
```