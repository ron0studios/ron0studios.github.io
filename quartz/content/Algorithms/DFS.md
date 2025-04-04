# Depth First Search
---
> The traversal of a [[tree]] recursively.^[this also works perfectly with a [[graph]] ] 

## Methodology
---
You can perform depth first search on a tree by looping thorugh all children of a node in a tree and recurse to each child. 
```python
FUNCTION dfs(node):
	if node is null:
		return;
	for i in node.children:
		if !visited[i]
			visited[i] = true
			dfs(i)
```

A good improvement is to have a `visited` [[hash map]], to keep track of already traversed nodes, which greatly improves the performance of the algorithm. 
Note that our base case in this situation is whether **node is null**, instead of checking if there are 0 children. This tends to be more compatible with programming languages and is less likely to lead to invalid access errors.

Depth first search operates on a **depth first** basis, meaning that it will recursively go through to the furthest point for a certain branch before trying out the other options. 