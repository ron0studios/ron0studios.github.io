# ch.1 - Recurrent Problems
---
>[!summary] An introduction on how to find closed-form solutions to recurrent problems
>The chapter begins with an introduction to the **Towers of Hanoi problem**^[very similar to a BIO problem [[Problems/Dreaming spires]]], and then proceeds onto more difficult problems, ending with the **Josephus problem**. 
>By the end of the chapter, we are given a very interesting insight into solving the Josephus problem using only [[bitwise operations]]. After exploring a more generalised approach to the problem we find out *why* using a cyclic left bit shift actually solves the Josephus problem, and how we can use a huge variety of generalised Josephus problems using bit-wise operations but in different number bases. 

> [!info] Opinions
> I personally really enjoyed this chapter and was mind blown by the generalised bit shift solutions! The fact you can solve such a huge class of recurrence equations by only using bit magic is amazing. 


## Things to watch out for 
### 1.1
There are $3^n$ combinations of Hanoi disks. This is because each disk can be placed in any of the $n$ pegs. For example, if we had 3 disks, we can place the biggest disk in any of the 3 pegs, and then the middle can go in any position, and the final can do the same. 

### 1.2
For the "zig" variation of the problem, note that it is defined as 2 **half-lines** coming out of a certain point. Since these are not 2 *full* lines, we can't make the claim that the closed form solution of this variation is just the same as the original problem but taking 2 steps at a time instead of 1. However you just need to reduce the number of regions created by $2n$ to account for the 2 other halves of the lines that never cut any new regions. 

### 1.3 
#### Binary representation
For the binary representation of the Josephus problem, note that since $b_m$ is always equal to $1$ because if we remember from the definition of the earlier solution being $$J(2^{m}+l)=2l+1$$
Therefore, we know that $2^{m}+l = n$. Since, from the book, the binary definition of $n$ is $$b_{m}2^{m} + b_{m-1}2^{m-1}+\ldots+b_12+b_0$$So since $n \geq 2^m$, the leading bit must **always** equal 1, since the leading bit has $2^m$ as the power. 

Likewise, since $l=n-2^m$, the leading bit of $l$ must **always** be 0. 

#### Repertoire method
Note that our **3 base cases** used to create the simultaneous equations to solve $\mathcal{A}(n)$, $\mathcal{B}(n)$ and $\mathcal{C}(n)$, are as follows.

> [!quote] $\alpha = 1, \beta=\gamma=0$
> This is the case where: 
> $$\begin{gather}
> \mathcal{A}(1)=1, \\ 
> \mathcal{A}(2n)=2\mathcal{A}(n), \\
> \mathcal{A}(2n+1)=2\mathcal{A}(n)
> \end{gather}$$
> This is probably the *intuitive* first base case you could come up with, by using an identity function, and having $\beta$ and $\gamma$ having zero effect. 

> [!quote] $\alpha = 1, \beta=\gamma=-1$
> This is the case where: 
> $$\begin{gather}
> \mathcal{A}(1)=1, \\ 
> \mathcal{A}(2n)=2\mathcal{A}(n)-1, \\
> \mathcal{A}(2n+1)=2\mathcal{A}(n)-1
> \end{gather}$$
> This one is less obvious, but you can find it by finding $\alpha, \beta \text{ and } \gamma$ in **reverse**. 
> If you rephrase the equation like *this* you can solve for the 3 variables.
> $$\begin{gather}
> 1=\alpha, \\ 
> 1=2\cdot1+\beta, \\
> 1=2\cdot1+\gamma
> \end{gather}$$

> [!quote] $\alpha = 1, \beta=0, \gamma=1$
> This is the case where: 
> $$\begin{gather}
> \mathcal{A}(1)=1, \\ 
> \mathcal{A}(2n)=2\mathcal{A}(n), \\
> \mathcal{A}(2n+1)=2\mathcal{A}(n)
> \end{gather}$$
> This one can be found similarly to the previous scenario, but this time phrasing $f(n)=n$ instead of $f(n)=1$
> $$\begin{gather}
> 1=\alpha, \\ 
> 2n=2\cdot n+\beta, \\
> 2n+1=2\cdot n+\gamma
> \end{gather}$$

#### Generalised recurrence (p15+)
This part confused me a lot and took me a while to get, but its very revealing. Its quite hard for me to explain using just text, but [this stack exchange post](https://math.stackexchange.com/questions/3771767/concrete-mathematics-where-is-the-cyclic-shift-for-rewritten-generalised-joseph) highlighted some of the problems I had. 
On top of that resource, note that page 15 isn't exactly showing a cyclic bit shift, so don't expect there to be a $\beta_{b_{m}}$ at the end of the binary representation. 
Instead, page 15 is showing that since $\beta_{\set{i,j}} \in \set{1,-1}$^[i.e in the recurrence since the two recurrence functions are 2n **+ 1** and 2n **- 1**], meaning that it isn't a *typical* binary expression where the digits can only be 1 or 0. This means our binary expression would look something like this $(1,-1,-1,1,-1,1)_2$. 
However, since we now allow for negative binary digits, it means that when convert our solution, it actually **transforms** the solution to a cyclic shift. If that does not make sens, please refer to the table on *page 16*. 
Also refer to the example the show just below the table: $$(1,-1,-1\ldots-1,-1)_{2}=(0,0,0\ldots0,1)_2$$ Try checking for yourself by hand its very cool!


