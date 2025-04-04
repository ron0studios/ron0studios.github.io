# 3.1 - Proof strategies
---
### 1(b)
![[Pasted image 20220731171347.png]]
> In an instance where $n=15$,  $n$ i s an integer greater than 1 and not prime, meaning that all hypotheses hold true, therefore leading to the conclusion that $2^n-1$ is also not a prime number. Since $2^{15}-1= 32767$, and $32767$ is **not** a prime number, this conclusion is correct. 

### 1(c)
![[image-20220731173019877.png]]

> Since $n = 11$ and $n$ **is** a prime number, not all of the hypotheses of the theorem are met, therefore the conclusion could be either prime or not prime, as derived from the truth table of a conditional. Therefore, the conclusion is essentially useless.

---
### 2(a)
![[image-20220731173523479.png]]

> There is only 1 hypothesis, which is that $b^2>4ac$. The conclusion in this theorem is that there are 2 real values of $x$ such that $ax^2+bx+c=0$ . 

### 2(b)
![[image-20220731173732337.png]]
> $x$ in this case is a *bound* variable, meaning it is not required to be defined in an instance, since it is technically within the scope of a *universal quantifier*. 

### 2(c)
![[image-20220731174455446.png]]
> In an instance where $a=2, b=-5$ and $c=3$ since $b^{2}>4ac$ can be substituted by the values in the instance, we can verify whether the hypothesis is true by substitution: 
$$
\begin{gathered} 
 (-5)^{2} > 4(2)(3) \\
 25 > 24
\end{gathered}
$$
>Since $25 > 24$ is *true*, the theorem concludes that there are exactly 2 real solutions to $ax^{2} + bx +c = 0$, which, is indeed true, as both $x=\frac{3}{2}$ and $x=1$ satisfy the conclusion. 

### 2(d)
![[image-20220731180621057.png]]
>In an instance where $a=2, b=4$ and $c=3$ since $b^{2}>4ac$ can be substituted by the values in the instance, we can verify whether the hypothesis is true by substitution: 
$$
\begin{gathered} 
 (4)^{2} > 4(2)(3) \\
 16 > 24
\end{gathered}
$$
>The resulting statement $16>24$ is false, meaning that the conclusion can be either true or false, as can be verified using a truth table for a conditional. This means nothing can be concluded in this instance, but the theorem is still held true. 

### 3
![[image-20220801171341984.png]]

> The hypotheses of this theorem are that $n$ is a natural number such that $n > 2$ and $n$ is not prime. The conclusion of this theorem is that $2n+13$ will also not be a prime number. 
> This theorem is shown to be incorrect through an instance where $n=8$. 
> In this instance, even though 8 is a natural number greater than 2, the conclusion $2n+13$ can be evaluated as equal to 29, which *is* a prime number.
> Since the hypotheses are true and the conclusion false, the theorem itself is false.

### 8
![[image-20220801172444265.png]]

> In order to prove that $x \in B$ follows from $x \notin D$, it suffices to prove the contrapositive, in which $x \notin B$ is assumed, allowing for $x \in D$ to be proved instead.
> 
>  As it is already given that $x \in A$, using the earlier assumption, it can be obtained that $x \in A \backslash B$. 
>  
> Since $A \backslash B$ is a subset of $C \cap D$, it is also true that $x \in C \cap D$. $x$ being an element of $C \cap D$ means that it is an element of $D$.
> 
> This proves $x \in D$, given the assumption $x \notin B$, which provides a proof of the theorem, using the contrapositive. 


### 9
![[image-20220801180611994.png]]
> Suppose that $x \in A$. In order to prove that $x \notin B$ follows from $x \in D$, it suffices to prove the contrapositive, such that $x \in B$ is assumed, allowing for $x \notin D$ to be proved instead.
> 
> As both $x \in A$ and $x \in B$ are both assumed, it can be obtained that $x \in A \cap B$. 
> 
> Since $A \cap B$ is a subset of $C \backslash D$, it is also true that $x \in C \backslash D$. $x$ being an element of $C \backslash D$ means that it is not an element of $D$. 
> 
> This proves $x \notin D$, given the assumption $x \in B$, proving $x \in D \rightarrow x \notin B$, using the contrapositive. As $x \in A$ was assumed, this then proves the theorem.

### 13
![[image-20220801182257528.png]]
> In order to prove that $y < 1$  follows from $x > 1$, it suffices to prove the contrapositive, in which $y \geq 1$ is assumed, allowing for $x \leq 1$ to be proved instead
> 
> As $y \geq 1$ has been assumed, we can re-arrange the hypotheses as follows:
$$
\begin{gathered}
3x \leq 5 - 2y \leq 3 \\
3x \leq 3 \\
x \leq 1
\end{gathered}
$$
> This proves $x \leq 1$ when $y \geq 1$ is assumed, proving the theorem using the contrapositive. 

### 16(a)
![[image-20220801195624815.png]]
> It is incorrect to assume that $x=7$ whilst trying to prove $\frac{2x-5}{x-4}=3$. This is because whilst all cases of $\frac{2x-5}{x-4}=3$ yield that $x=7$ should also, be true, the same is not true vice versa, since $x=7 \rightarrow \frac{2x-5}{x-4}=3$ could be true if the antecedent is true and the consequent false, but $\frac{2x-5}{x-4}=3 \rightarrow x=7$ would be false in the same instnace, rendering the outcome of the theorem as false if the hypotheses were true.

### 16(b)
![[image-20220801202718954.png]]
> Suppose $\frac{2x-5}{x-4} = 3$. We can rearrange this equation as follows:
$$
\begin{gathered} 
\frac{2x-5}{x-4}=3 \\ 
2x-5 = 3x-12 \\ 
x-7 = 0 \\
x = 7
\end{gathered}
$$
>Since $x \neq 4$, the possibility of an undefined answer, due to division by zero, is ruled out, and therefore, using the assumption of $\frac{2x-5}{x-4} = 3$, the theorem is proven.

### 17(a)
![[image-20220801204525714.png]]
> The proof makes the incorrect deduction that "Since $x \neq 3$, $x^{2} \neq 9$ ", whereas there is another number that can be squared to make 9, being $-3$. 
>
>
> *note: 17(a) has a typo in it. It should say $x^{2}-9 \neq 0$ instead of $=$.*

### 17(b)
![[image-20220801205334754.png]]
> In an instance where $x=-3$ and $y=2$:
$$
\begin{gathered} 
(-3)^{2}(2)=9(2) \\
9\times2=9(2) \\
18 = 18 
\end{gathered}
$$
> The statement $18=18$ is true, and $x \neq 3$, but $y\neq0$, disproving the theorem.
