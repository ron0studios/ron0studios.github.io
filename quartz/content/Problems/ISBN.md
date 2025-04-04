#bio
# ISBN
---
> A 2003 BIO problem, which had an easter egg


# Explanation
---
the easter egg, per se, is that you cant just take the remainder, since there's the risk that the quotient is non divisible

# Code
---
```c++

// isbn
void solve(int tc)
{
	string s; cin >> s; 

	int missing_total = 0;
	int missing_index = -1;
	// calc with missing
	for(int i = 0; i < 10; i++)
	{
		if(isdigit(s[i]))
		{
			missing_total += (s[i]-'0')*(10-i);
		}
		else if(s[i] == 'X')
		{
			missing_total += 10;
		}
		else{
			missing_index = i;
		}
	}

	int remainder = 11-(missing_total % 11);
	//int out = remainder/ (10-missing_index);  // YOU CANT DO THIS!
	int c = 0;
	while(true)
	{
		if(missing_total % 11 == 0) break;
		missing_total += (10-missing_index);
		c += 1;
	}
	int out = c;

	if(out==10)
		cout << "X\n";
	else
		cout << out << "\n";


}


```