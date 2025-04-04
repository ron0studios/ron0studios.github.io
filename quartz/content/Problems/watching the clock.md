#bio
# watching the clock
---
> Modulo problem from BIO 2013 Q1


# Explanation
---
This is a time / time-based problem, requiring the modulo of a clock

# Code
---
```cpp

string t2str(int a)
{
	string hours = to_string(int(floor(a/60))); 
	string minutes = to_string(a%60);

	if(hours.length() < 2) hours = "0"+hours;
	if(minutes.length() < 2) minutes = "0"+minutes;
	return hours+":"+minutes;
}

void solve(int tc)
{
	int a,b; cin >> a >> b;
	// 1440
	if(a==b) 
	{
		cout << t2str((a+60) % 1440) << "\n"; return;
	}

	int t1, t2;
	t1 = (60+a)%1440;
	t2 = (60+b)%1440;
	while(true)
	{
		//cout << t2str(t1) << " "<< t2str(t2) << endl;
		//usleep(100000);
		if(t2str(t1) == t2str(t2)) 
			break;
		t1 += 60 + a;
		t2 += 60 + b;
		t1 %= 1440;
		t2 %= 1440;
	}
	cout << t1 << " " << t2 << "\n";
	cout << t2str(t1) << "\n";
}
```