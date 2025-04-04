# daily temperatures
---
>[!summary] Leetcode 739. Took around 1 hour


# Explanation
---
[[stack]] problem similar to [[]]

# Code
---
```python
def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
	#out = [0 for d in range(len(temperatures))]
	stack = [(temperatures[0], 0)]

	for i in range(1,len(temperatures)):
		while len(stack) and temperatures[i] > stack[-1][0]:
			temperatures[stack[-1][1]] = i-stack[-1][1]
			stack.pop()
		stack.append((temperatures[i], i))

	for i in stack:
		temperatures[i[1]] = 0
	
	return temperatures
```