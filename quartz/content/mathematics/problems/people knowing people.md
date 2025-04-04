# people knowing people
---
>[!summary] There are 10 people in a room. Some of them might know each other but some might not. Using pigeonhole principle, show that at least two of them know the same number of people in the room. State clearly what is the pigeonhole and what is the pigeon.
>


# Explanation
---
There are really only **2** sets of options for how many other person one can know among the 10 people. If any one person knows **nobody**, i.e. **0 people**, that means it is impossible for any one person to know 9 other people, giving us the set of possibilities of $\set{0,1,\ldots,8}$. However if atleast one person knows **everybody** then there cannot exist a person who knows 0 people, giving us the set of possibilities of $\set{1,2,\ldots,9}$.  Both of these ranges have a size of **9**.

Therefore if our pigeons are the 10 people and the pigeonholes being the options for the number of people they can know, which will be a set of 9, then according to the pigeonhole principle, there will always be $\lceil\frac{10}{9}\rceil = 2$ people who share the same number of other people they know!