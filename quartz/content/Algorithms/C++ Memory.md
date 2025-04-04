# C++ pointers and memory
---
> Memory allocation in low-level languages are a nightmare, but they're very fun to do!


# Heap vs Stack
---
## The stack
The stack is, well, a regular algorithmic [[stack]], which stores memory side by side. It is allocated just like any other c++ variable
```cpp
int x = 3
Object y("hello");
```
Since the stack has elements next to each other, and simply uses a pointer that shifts *X* bytes whenever we want to allocate new memory, it's extremely fast^[with a time complexity of **O(1)**] 
Here's the problem though, the stack can only free memory by removing the top. This makes it really slow when you have a lot of variables being removed. 

## The heap
The heap solves this issue! The heap is, well a regular algorithmic [[heap]], or [[priority queue]]. As you (me) may already know, a PQ has a deletion time complexity of **O(logn)**, which is considerably faster than that of a stack^[**O(N)**] . This makes it useful for when the lifespan of your data is outside of the current scope, i.e accessing and modifying variables in other functions, by referencing it. It does mean, however, that you will have to manually delete the memory, since it doesn't delete itself like a stack does at the end of the scope. 
You declare variables to a heap by using pointers; 
```cpp
int *x = new int;
*x = 5 ; / / dereferencing and assigning
Object* y  = new Object();
```
When the pointer variable x is created, it is allocated to the memory heap, using the *new* keyword. We then dereference x, and assign it a value. 
Objects are also created with the new keyword. 
However, since heaps require **logn** complexity for most actions, it can be considered very slow, especially due to memory being requested at times. It is useful for big objects or objects you want to be persistent.

# Unique and shared pointers
---
#tofinish

Both unique and shared pointers are examples of *smart pointers*. These are pointers that will delete themselves^[hold on, I thought pointers were persistent outside of scope? well, the memory allocated is persistent, but the pointer variable itself is destructed!] when it reaches the end of its scope. Unique pointers create a 1-1 ownership of the pointer to the memory, meaning that, in order to pass it on, you have to use the *move* function to transfer ownership to another pointer. 
