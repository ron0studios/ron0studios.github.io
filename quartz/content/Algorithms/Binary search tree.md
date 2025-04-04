# Binary Search Tree

>
A binary search tree is a specialized binary [[tree]] in which all nodes are searchable in **O(log n)** time.

Within a binary search tree, for any node X that is not a leaf of the given tree, it's left child has a lower value than X, and the right child has a higher value. This allows for a variety of options, such as finding the biggest element, the smallest element, or any element in a very short space of time.  
- The biggest element can be found by traversing continually rightwards until the rightmost node is found.  
-  The smallest element can be found by traversing continually leftwards until the leftmost node is found. 
-  Finding a specific node can be done by starting at the root and traversing left if the desired node is smaller than the root, right otherwise. We keep doing this until the node matches the desired node.
-  We can display all nodes in [[sorting|sorted]] order in **O(N)** time by using [[Binary tree traversal#Inorder]] tree traversal.
- The predecessor of any node is the rightmost node in its **left** subtree^[what is the biggest element that is smaller than X? (intuition)]
- The successor to any node is the leftmost node in its **right** subtree^[what is the smallest element that is bigger than X? (intuition)]


## Time complexity
The time complexity of finding any node is O(H), where H is the height of the tree. Since the height of a perfect binary tree tends to always be log(N), where N is the number of nodes in the tree, then we can re-state the time complexity, more commonly as **O(logN)**[^1]


[^1]: Note that if the binary tree is not balanced properly, then the time complexity can end up being as slow as O(N). To avoid this, try using a self-balancing binary search tree, such as a [[Red Black Tree]].