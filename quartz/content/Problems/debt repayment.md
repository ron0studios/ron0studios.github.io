#bio
# debt repayment
---
> Pretty easy BIO 2018 Q1 with a slight twist [[ad hoc]]


# Explanation
---
The slight twist in this problem is how specific it is for **where** you are to use rounding in your floating-point calculuations. Rounding is only to be done on percentage calculations and nothing else. 
If you do it anywhere else,  your answers for the bigger testcases will fail!

# Code
---
```cpp

void solve(int tc)
{
	double intrate, reprate; cin >> intrate >> reprate;

	intrate = (intrate/100.0d);
	reprate = (reprate/100.0d);


	cout.precision(17);
	double tot_rep = 0.0d;
	double cur = 100.0d;
	while(true)
	{
		if(cur <= 0)
			break;

		cur += ceil(cur*intrate*100.0d)/100.0d;

		double rep = ceil(max(50.0d, cur*reprate)*100.0d)/100.0d;
		cur -= rep;
		tot_rep += rep;
		if(cur < 0)
		{
			tot_rep -= abs(cur);
		}
	}
	cout << tot_rep << "\n";
}


```