---
aliases: 
date: 2025-01-30
time taken (mins):
---
# c++ features
---
> Personal notes on random facts about the C++ language or modern C++. Will split into multiple notes if it gets too big 👍


## casting
### Why do we have 4 different casts?
Why do we need a `const_cast` and not just merge that into the other casts? 
Well we know `reinterpret_cast` is useful since it allows us to cast to a type without modifying any of the bits present, just interpreting how we read the bits differently. 
We also know 

## memory
### nothrow
According to [C++ reference](http://www.cplusplus.com/reference/new/operator%20new/), you can new an object by:
```cpp
MyClass * p1 = new MyClass;
```
or by
```cpp
MyClass * p2 = new (std::nothrow) MyClass;
```
The second one will return a null pointer instead of throwing an exception.

