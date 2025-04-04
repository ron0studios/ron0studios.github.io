# Brute forcing
---
> going through all solutions for an answer, basically an alias to [[complete search]]


## using iteration
---
Brute forcing an answer is sometimes an acceptable approach for solving a question, assuming its input range is small. A common method of brute force is to loop through the possible answers iteratively, usually through nested for loops. 
This method can take anywhere from **O(N)** to **O(N^2)** time. 


## using recursion
---
Recursive solutions are also plausible, but far more dangerous because they usually require **O(x^n)** time, where **x** is the number of recurses a function can make^[i.e the number of possible choices you want to simulate], and **n** the maximum depth of the recursion [[tree]] , which can easily slow to a halt at 10-15. 

However, more optimized versions of brute forcing can be accomplished using [[dynamic programming]], where a [[complete search]] can be applied whilst caching (memoising) certain results, helping to reduce time complexity from **O(x^n)** to usually something more tame such as **O(n^x)** or even less! Caching prevents backlinks to already traversed nodes, keeping the recursion tree as a [[tree]] and *not* a [[graph]]!