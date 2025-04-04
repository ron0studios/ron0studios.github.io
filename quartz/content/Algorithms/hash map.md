# Hash Map
>
The hash map is an essential data structure that stores data in key value pairs.

An impressive feature of the hash map is its extremely effecient constant lookup time of **O(1)**, making it very useful to find the data necessary. 

## in C++
In c++, the hashmap can be implemented as either a *map*, or an *unordered map*. A regular map operates in the same way as the unordered map with the exception that data is explicitly ordered, and the downside of slower O(log n) lookup time. Try to use an unordered_map whenever possible. 

> [!warning] LIABLE TO HACKING
> **If your code ends up getting hacked, or if you keep failing (TLE) at a very late-stage test case, then it may be that the numbers are multiples of the same primes that the hash of an `unordered_map` is using. In this case, please use a `map` instead!!**


> [!danger] **Be careful!!**
> **ONLY** use the `[]` operator in a map **when you need to**. The `[]` operator *creates a new element* when an element does not exist, which can be very taxing at a large scale^[**O(N)**].  
> In a lot of [[dynamic programming]] problems I have incorrectly used this operator when checking whether a certain key is in the map, leading to TLEs. Instead use the `contains()` method. You can, alternatively, use `count()` if you are not on *c++20*. 
> ---
> ### TLDR;
> **use `[]` if you are ok with creating new keys! if not use `contains()` or `count()`**
> 
> ---

```ad-warning
Look out for this error!
![[Pasted image 20210812193644.png]]
The *deleted function* error means that there is no hash function available that can encode the key data-type that you have provided. In this case, it's best to stick with a regular map!
```