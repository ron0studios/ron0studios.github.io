# conveyor belts
---
>[!summary] A somewhat visually tricky problem


# Explanation
---
This problem requires a lot of spacial/coordinate visualisation, and definitely knowledge on the [[matrix]]. 

Essentially, the method is to find out which conveyor belt each coordinate is in, and since following along with the conveyor belts dont actually use up energy, and only moving manually does, therefore the least amount of energy spent would simply just be to move from one conveyor belt to the other until you reach the right belt. 

The hardest part is finding out which conveyor belt a coordinate is in. The way I did this is by looking at the coordinates carefully, and noticing that certain values remain the same (e.g the y coordinate), when you are in one side of the belt, the side on the left or right of the diagonal^[the bottom left to top right one]. 

You can se the code yourself to see how this works out. 

# Code
---
```cpp
void solve(int tc)
{
	int n, x1, y1, x2, y2; cin >> n >> x1 >> y1 >> x2 >> y2;
	x1--; y1--; x2--; y2--; n--;

	int belt1, belt2;
	if(x1+y1 < n){
		belt1 = min(x1,y1);
	}
	else{
		belt1 = n-max(x1,y1);
	}

	if(x2+y2 < n){
		belt2 = min(x2,y2);
	}
	else
	{
		belt2 = n-max(x2,y2);
	}
	
	cout << abs(belt1-belt2) << endl;
}
```