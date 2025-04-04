# remove k digits
---
>[!summary] neat leetcode problem


# Explanation
---
this is a [[stack]] problem where you simply add the numbers from the string to a stack. if the element-to-be-inserted is smaller than the element before it, then keep popping from the stack until that is no longer the case, or until `k` runs out. 

# Code
---
```python
def removeKdigits(num: str, k: int) -> str:
    out = [num[0]]
    q = list(num[1:])

    while k > 0:
        #print(out,k,q)
        if not len(q):
            out += q
            while k:
                out = out[:-1]
                k -= 1
            break
        
        front = q[0]
        q.pop(0)

        if front >= out[-1]:
            out.append(front)
        else:
            while front < out[-1]:
                if k == 0:
                    break
                
                out = out[:-1]
                k -= 1

                if not len(out):
                    break

            out.append(front)
            
    out += q
    
    if not len(out):
        return '0'
    
    
    while out[0] == '0':
        if len(out)==1: break
        out = out[1:]

    return ''.join(out)

```