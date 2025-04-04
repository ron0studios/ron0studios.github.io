#bio
# block palindromes
---
> find the number of ways you can turn an **N** length number into different block palindromes. This is a relatively simple [[combinatorics]] problem
> An example of a block palindrome for 21321 would be:
> >**(21)(3)(21)**
> 
> not to be confused with [[Palindromic numbers]] from the BIO2019 R1


# Explanation
---
The way the program works is that it has the main function, **blockify** which recursively finds different orders of blocks.
We check the first **i** letters and see if that substring matches the last **i** letter substring of the main string. If so, we know that this is a possible block and increment count, recursively looking into the substring excluding those 2 matching blocks.

> **e.g**
21321
(2)132(1) *doesnt work*
(21)3(21) *works!* +1
(3) *works!* (we don't add 1 because the length is 1, since we floor divide)

# Code
---
```python
inp = input()

count = 0

# st refers to string
def blockify(st):
    global count
    if st == "":
        return 
    
	# recursive section, skips if len(st) <= 1
    for i in range(len(st)//2):
        
        if st[:i+1] == st[-(i+1):]:
            count += 1
            blockify(st[i+1:-(i+1)])
    


blockify(inp)
print(count)
```