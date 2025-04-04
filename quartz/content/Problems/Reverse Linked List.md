# Reverse Linked List
---
>[!summary] leetcode 206. Classic [[Linked list]] problem. Can be solved [[recursion|recursively]]. took 20 mins (20 more minutes for iterative ver.)

# Explanation
---
Essentially, you traverse the linked list, and set the next pointer of each element to the one before it. You will need to create a temporary pointer to be able to traverse the node after that, since we are modifying the `next` pointer.
# Code
---
### [iterative solution](https://leetcode.com/problems/reverse-linked-list/submissions/1439298436)
```cpp
ListNode* reverseList(ListNode* head) {
	if(!head) return nullptr;

	ListNode* cur = head->next;
	ListNode* prv = head;
	
	while(cur != nullptr){
		ListNode* nxt = cur->next;
		cur->next = prv;
		prv = cur;
		cur = nxt;
	}
	head->next = nullptr;
	return prv;
}
```


### [recursive solution](https://leetcode.com/problems/reverse-linked-list/submissions/1439309165)
```cpp
    ListNode* reverseList(ListNode* head, ListNode* prev = nullptr) {
        if(!head) return nullptr;
        if(!head->next) {
            head->next = prev;
            return head;
        }
        ListNode* nxt = head->next;
        head->next = prev;
        return reverseList(nxt, head);
    }
```