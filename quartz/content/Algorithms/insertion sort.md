# insertion sort
---
>[!summary] A basic **[[Algorithms/online|online]]** [[sorting]] algorithm. 


# Explanation
---
This algorithm works by going through each element one by one, and then shuffling that element to the *left* into a partially sorted subset until the full array is sorted. This is kind of like the reverse of [[Bubble Sort]], which "bubbles" elements to the *right* of an array, where the partially sorted subset is to the right instead of the left.

# Code
---
```python
def insertionSort(lst):
    if len(lst) < 2:
        return lst

    for i in range(1,len(lst)):
        j = i
        removedItem = lst[i]
        while j > 0 and removedItem < lst[j-1]: 
            lst[j] = lst[j-1]
            print(lst)
            #lst[j], lst[j-1] = lst[j-1], lst[j]
            j -= 1
        lst[j] = removedItem 

    return lst
```