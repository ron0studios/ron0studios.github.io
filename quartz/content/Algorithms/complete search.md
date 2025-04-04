# Complete search 
---
> Complete search is the process of [[Brute force|brute forcing]] all possibilities in a choice based problem 


## Recursively^[[[recursion]]]
---
### methodology
---
The most common way to complete search through a range of possible decisions is through recursion, in which a function recurses to simulate what would happen if it made a certain choice on its own input, recursing all possible choices at its current state. 
This creates a [[tree]] of possibilities in which a desired answer can be found. 

```python
 FUNCTION compute(data):
	 if data == answer:
		 print("ANSWER FOUND!!!! :D")
	 if data <= 1:
		 return data

	 for i in choices:
		 compute(i(data))
```

### When finding the minimum choices
---
Sometimes, you may want to stop the algorithm once you've found the correct answer. Using recursion like the example above may be difficult.

Here's one way of doing this
```python
 FUNCTION compute(data):
	 if data == answer:
		 print("ANSWER FOUND!!!! :D")
		 forcefully_exit(0)
	 if data <= 1:
		 return data

	 for i in choices:
		 compute(i(data))
```

whilst you *could* forcufully exit the program on finding the answer, there is still an underlying issue at hand. Take a look closer at the structure of how we're generating this [[tree| complete search tree]]. The recursive solution is resemblant of [[DFS| Depth first search]], which we know loops through a tree **depth first**, essentially column by column instead of row by row. 

If we are to find the earliest point in the tree in which an answer is applicable, even if we forcefully exit the program, we would have traversed many branches to its maximum depth unnecessarily. Even worse, we might have found *another* occurence of the answer somewhere in the earlier depth-first traversals further into the tree, leading to an answer that is wrong!

We need a way of traversing the tree, *layer by layer*, which **[[Greedy|greedily]]** allows us to find the first occurence of an answer. This can be solved by using the *other* tree traversal algorithm [[BFS|Breadth First Search]]. Not only does this find a correct answer, but it can also be simply broken out of using a **break** statement instead of forcefully terminating the program. 
Furthermore, we can have a [[hash map]] that can prevent already attempted paths from being tried again. This keeps the complete search tree as a tree and not a [[graph]]!



## Iteratively
---
An iterative solution usually involves a few `for` loops going through a set of data, such as going through a set of coordinates and finding a maximum result. **There are some important optimizations you can do to your code**

### Optimization
---
In a naive complete search of all pairs in a set of data, you would run two loops nested within each other, as such: 
```cpp
for(int i = 0; i < n; i++)
{
	for(int j = 0; j < n; j++)
	{
		do_thing();
	}
}
```

This algorithm runs in **O(N<sup>2</sup>)** time complexity, which is *slow*. This is because there are two loops, with *N* repeats running. However, there is a way we can optimise this. 

Consider the following data and the result of our naive solution:
$$
\begin{gathered}
	Array\ x= [1,2,3] \\
\end{gathered}
$$
The naively generated solution would be as follows:
$$
\begin{gathered}
naive(x) = [\ (1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3)\ ]
\end{gathered}
$$
There are quite a few problems with this. Firstly, we're generating all possible **permutations** of pairs, instead of all **combinations**! Consider `(1,2)` and `(2,1)` for example. 
Sometimes, we also don't want to be comparing an element with itself, so having pairs such as `(1,1)` or `(2,2)` are a no go.

Using [[combinatorics]] knowledge, we can see why this is the case. The total permutations of pairs, without removing values from the array, would be $3^{2}= 9$. However, the total combinations alongside excluding same-value pairs would be $\frac{3^{2}-3}{2} = 3$.  This boils our time complexity to around **O(N<sup>2</sup>/2)**!

Lets see an algorithm for this:
```cpp
for(int i = 0; i < n; i++) 
{
	for(int j = i+1; j < n; j++)
	{
		do_thing();
	}
}
```
this solution works for 2 reasons:
	- the `+1` in the 2nd for loop means that the possibility of $j==i$ is excluded entirely, removing same value pairs.
	- setting the nested for loop to `j = i+1`, means we won't have same combinations being repeated, because we would have already had a case where $i=x$ and $j=y$ earlier in the loop, so there is no need to traverse back to where `i` has already been via `j` in the search. 


## Generating permutations
Sometimes we need to be able to check every permutations of an $N$ sized array, string or any data structure. While this can be done recursively, it is generally slower and takes time to do. luckily, in c++ there is a simple STL way. 
```cpp
do {
check(v); // process or check the current permutation for validity
} while(next_permutation(v.begin(), v.end()));

```
> [!warning] Be careful with this method! 
> here are some things to be mindful of:
> - The function directly changes the data being sent to it^[notice the iterators], so you may want to create a copy
> - A do-while loop is **crutial** if you also want to include the original data itself before it is touched by the function.
> - **if you want to use this method to generate all permutations, make sure the original data is properly [[sorting|sorted ]]in lexographical order!!!**

## Generating subsets
> [!warning]
> this is pseudocode from the competitive programmer's handbook
```cpp
void search(int k) {
	if (k == n) {
		// process subset
	}
	else 
	{
		search(k+1);
		subset.push_back(k);
		search(k+1);
		subset.pop_back();
	}
}
```
