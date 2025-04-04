# sort! sort!! and sort!!!
---
>[!summary] UVA 11321. A [[sorting]] problem (who would have guessed 💀). Took around 18 mins.


# Explanation
---
This problem requires you to distinguish not only by $x\bmod M$, but also the *parity*^[odd or even-ness] of $x$. We can use a similar technique to [[contest scoreboard]] or [[stable groups]], and just create a *vector* of all the properties we need to sort by, and apply $\pmb{x\mapsto-x}$ when we need to sort in *descending* order instead of ascending. Later elements in the vector get less *priority* when sorting. 

> [!warning]
> This problem is not **exclusive** to unsigned variables! Be wary of the possibility of *negative* numbers showing up in the input! An example of a line that makes sure to avoid any complications in the code is `line 8` where you **have** to apply the `abs()` function to avoid having negative parity.
# Code
---
```cpp
void solve(int n, int m)
{
	vector<vector<int>> arr(n, vector<int>(4));
	for(int i = 0; i < n; i++){
		int x; cin >> x;
		arr[i][3] = x;
		arr[i][0] = x % m;
		arr[i][1] = -(abs(x) % 2);
		if(x%2){
			arr[i][2] = -x;
		}
		else arr[i][2] = x;
	}

	sort(arr.begin(), arr.end());
	for(int i = 0; i < n; i++){
		cout << arr[i][3] << endl;
	}

}
```