# Binary tree traversal
>
Inorder, Postorder, and Preorder binary [[tree]] traversal allows for the search of a binary tree recursively with ease.

## Postorder
Postorder tree traversal attends to a certain node after the full recursive traversal of both left and right connections. In this case, the root of the tree is printed last, whilst the leaves are printed last.
Since nodes are printed from bottom to top, we can guarantee that once a node is printed, both its children must have already been printed, therefore postorder traversal is a very useful method of deleting a tree without creating any disconnected nodes. ^6a2e48

```c++
void printPostorder(struct Node* node)
{
	if (node == NULL) // IMPORTANT
		return;

	// first recur on left subtree
	printPostorder(node->left);

	// then recur on right subtree
	printPostorder(node->right);

	// now deal with the node
	cout << node->data << " ";
}
```


## Inorder
Inorder tree traversal interacts with a node once the left branch has been traversed, and then the right branch is traversed. This form of traversal is incredibly useful in the case of [[Binary search tree]], where an inorder traversal of one prints the tree in ascending order (*smallest to biggest*).

```c++
void printInorder(struct Node* node)
{
	if (node == NULL)
		return;

	/* first recur on left child */
	printInorder(node->left);

	/* then print the data of node */
	cout << node->data << " ";

	/* now recur on right child */
	printInorder(node->right);
}
```

## Preorder
Preorder is exactly like [[#^6a2e48|Postorder traversal]] with the only difference being that the nodes are interacted with before any of the two branches are accessed. The main use for Preorder traversal is precisely the opposite as Postorder traversal - for the creation of a tree. 

```c++
void printPreorder(struct Node* node)
{
	if (node == NULL)
		return;

	/* first print data of node */
	cout << node->data << " ";

	/* then recur on left sutree */
	printPreorder(node->left);

	/* now recur on right subtree */
	printPreorder(node->right);
}
```