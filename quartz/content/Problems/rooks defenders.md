# rooks defenders
---
>[!summary] An interesting codeforces problem


# Explanation
---
There are a couple of solutions to this problem. The way I solved this was by using a [[Algorithms/Fenwick Tree]]. I would maintain 2 Fenwick trees, for `rows` and `cols`, since a subrectangle is guaranteed to be pinned by a rook at all squares, if either all rows or all columns have atleast 1 rook in it. 

However, there is a more efficient solutions, which is to use a [[sorting|sorted]] array for both rows and cols to see which rows/cols are free of any rooks. You can use [[binary search]] to search through them in $\mathcal{O}(logN)$ time. 
# Code
---
## Fenwick tree solution
```cpp

void solve()
{
	int n, q; cin >> n >> q; 
	vector<int> rows(n+1,0);
	vector<int> cols(n+1,0);

	vector<int> rcnt(n+1,0);
	vector<int> ccnt(n+1,0);

	for(int i = 0; i < q; i++)
	{
		int t; cin >> t;
		if(t == 1)
		{
			int x, y; cin >> x >> y;
			rcnt[x] += 1;
			ccnt[y] += 1;

			if(rcnt[x] == 1)
			while(x <= n) {
				rows[x] += 1;
				x += x&-x;
			}
			
			if(ccnt[y] == 1)
			while(y <= n) {
				cols[y] += 1;
				y += y&-y;
			}
		}
		else if(t==2)
		{
			int x, y; cin >> x >> y;

			rcnt[x] -= 1;
			ccnt[y] -= 1;

			if(rcnt[x] == 0)
			while(x <= n) {
				rows[x] += -1;
				x += x&-x;
			}

			if(ccnt[y] == 0)
			while(y <= n) {
				cols[y] += -1;
				y += y&-y;
			}
		}
		else
		{
			int x1,y1,x2,y2; 
			cin >> x1 >> y1 >> x2 >> y2;

			int totx = x2-x1+1;
			int toty = y2-y1+1;


			int sx2 = 0;
			while (x2 >= 1) {
				sx2 += rows[x2];
				x2 -= x2&-x2;
			}

			int sx1 = 0; x1--;
			while (x1 >= 1) {
				sx1 += rows[x1];
				x1 -= x1&-x1;
			}
			


			if(sx2-sx1 == totx){
				cout << "yes" << endl;
				continue;
			}


			int sy2 = 0;
			while (y2 >= 1) {
				sy2 += cols[y2];
				y2 -= y2&-y2;
			}

			int sy1 = 0; y1--;
			while (y1 >= 1) {
				sy1 += cols[y1];
				y1 -= y1&-y1;
			}


			if(sy2-sy1 == toty)
				cout << "yes" << endl;
			else
				cout << "no" << endl;
		}
	}
}
```