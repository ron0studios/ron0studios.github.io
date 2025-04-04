#bio
# Mayan calendar
---
> BIO 2004 question 1. a tad bit weird but mostly easy


# Explanation
---
[[ad hoc]]
# Code
---
```cpp

int mayan2days(int ki, int ui,int tu,int ka,int ba)
{
	return ki + (20*ui) + (20*18*tu) + (20*18*20*ka) + (20*18*20*20*ba);
}

// mayan calendar
void solve(int tc)
{
	int kin,uinal,tun,katun,baktun; cin >> baktun >> katun >> tun >> uinal >> kin;
	int past2k = mayan2days(kin,uinal,tun,katun,baktun) - mayan2days(3,16,7,20,13); //13,20,7,16,3);
	int year = 2000;
	while(true){
		int sub = 365; 
		if(year % 4 == 0)
			sub=366;

		if(past2k - sub < 0) {
			break;
		}
		past2k -= sub;
		year++;
	}

	vector<int> m = {31,28,31,30,31,30,31,31,30,31,30,31};
	if(year%4 == 0) m[1] = 29;
	int month = 1;
	for(int i = 0; i < m.size(); i++)
	{
		int sub = m[i];
		if(past2k - sub < 0){
			break;
		}
		past2k -= sub;
		month ++;
	}

	int day = past2k+1; 

	cout << day << " " << month << " " << year << "\n";

}


```