# flipper
---
>[!summary] A hard codeforces problem


# Explanation
---
This is a fairly difficult [[Greedy]] problem that requires a bit of logic. 
Firstly, our main assumptions are that there are no duplicate numbers^[since there are $n$ distinct integers from $[1-n]$]. Not that those, assumptions will help much, but y'know, its good to know 👍.

Alright so the goal of the problem is to get all numbers in the largest **lexographical order** possible from a **single** operation. Therefore, our priority is to get the *maximum* number to the left side at all costs. 

After a bit of playing around with this, you will find that this is impossible to do in the scenario where the largest number takes the *first index* of the array. In this case, we simply take the 2nd biggest number instead^[And we can **guarantee** that this 2nd biggest number *is* possible to be moved to the right, because there will be a free space to the left of it for it to be swapped over].

We can break up the problem to 2 scenarios:
- The biggest (or 2nd biggest) number is the rightmost element.
- The biggest (or 2nd biggest) number is **not** the rightmost element.

## scenario 1

In scenario 1, we immediately know that the right index of the segment is the last element. This is because we want to get the biggest element to the left and the best way to do this is to include it in the segment. 
Now, we need to decide the left index. First, lets remember what happens in this operation. The segment chosen is reversed and the rest of the array, from $[0-left]$, is going to be moved to the right. Therefore, we need to keep decrementing the left index from the right, as long as the element of the left index is greater than the first element, which will be what gets swapped to the right after the operation. 


## scenario 2

In scenario 2, we immediately know that the right index of the segment is *one less than* the last element. This is because we need to get the biggest element to the left most point possible, and the only way to get this to happen is by making sure that nothing comes before it, hence having the segment end just before the biggest number. 
Now we need to decide the left index. We do the same thing for scenario 1


That's it!

> [!warning] note on codeforces submissions!
> codeforces will sometimes give you a **runtime error** (error code *3*), if you make any illegal actions in c++, even if your home computer does not detect it. Try to test this by running the program on the codeforces *custom invocation* tab, or using a debug executable.


# Code
---
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];

	if(n==1)
	{
		cout << a[0] << endl;
		return;
	}

	int mx = max_element(a.begin(), a.end()) - a.begin();
	if(mx == 0)
		mx = max_element(a.begin()+1, a.end())-a.begin();



	int left, right;
	if(mx == n-1)
	{
		if(a[mx-1] > a[0])
		{
			right = mx;
			left = mx-1;
			if(a[0] < a[mx])
				while(a[left] > a[0])
					left--;
			left++;
		}
		else
		{
			left = right = mx;
		}
	}
	else
	{
		right = mx-1;
		left  = mx-1;
		if(a[0] < a[mx] and left > 0){
			while(a[left-1] > a[0])
				left--;
		}
	}

	int frontlen = left;
	int backlen  = n-right-1;

	vector<int> seg = vector<int>(a.begin()+left, a.begin()+min(n,right+1));
	reverse(seg.begin(),seg.end());
	vector<int> out = {};
	if(backlen) out = vector<int>(a.begin()+min(n,right+1), a.end());
	out.insert(out.end(), seg.begin(), seg.end());
	if(frontlen) out.insert(out.end(), a.begin(), a.begin()+left);


	for(auto i : out)
		cout << i << " ";
	cout << endl;

}
```