#bio
# Upside down
---
> BIO 2011 Q3 


# Explanation
---
[[combinatorics]] and [[dynamic programming]]

very similar to [[new order]] where the length is needed, also kind of like other, find the nth, questions like [[all work no play]] or [[modern art]]

# Code
---
```cpp
void solve(int tc)
{
	ll n; cin >> n;
	vector<ll> dp(51,0);
	dp[1] = 1;
	dp[2] = 9;
	for(int i = 3; i <= 50; i++)
	{
		if(i%2) dp[i] = dp[i-1];
		else	dp[i] = pow(9, i/2);
	}

	int len = 0;
	ll tmpc = 0;
	while(true)
	{
		if(tmpc >= n){
			tmpc -= dp[len-1];
			len--;
			break;
		}
		tmpc += dp[len];
		len++;
	}
	if(len == 1) {
		cout << 5 << endl; 
		return;
	}

	int oglen = len;
	if(len%2) len--;
	string out = "";
	ll combs = tmpc;
	while(len)
	{
		int x = 1;
		for(int i = 0; i < 9; i++)
		{
			combs += pow(9, (len/2)-1);
			x++;
			if(combs >= n)
			{
				combs -= pow(9, (len/2)-1);
				x--;
				break;
			}
		}
		out += to_string(x);
		len -= 2;
	}

	string newstr = string(out.rbegin(), out.rend());
	for(int i = 0; i < (int)out.length(); i++)
	{
		newstr[i] = '0'+(10-(out[(int)out.length()-1-i]-'0'));
	}
	if(oglen%2){
		out = out + "5" + newstr;
	}
	else
	{
		out = out + newstr;
	}

	cout << out << endl;
}
```

```cpp

bool is0(int inp)
{
	if(inp==0) return true;
	if(inp<0) inp = -inp;
	while(inp > 0)
	{
		if(inp % 10 == 0)
			return true;
		inp /= 10;
	}
	return false;
}


// returns the number of n-digit integers greater than 1111...(*n) and less than num
int nonzero(int num)
{
	ll num_iter = num; 
	ll left = 0;
	
	// calculate non-containing-zero integers of N-digits up to and including num_iter
	string loop = to_string(num_iter);
	for(ll i = 0; i < loop.size(); i++)
	{
		int digit = loop[i]-'0';

		left += max(0,digit-1)*pow(9,loop.size()-i-1);
	}
	if(!is0(num_iter))
		left++;

	if(num_iter!=left){
		left = num_iter + (num_iter-left) + 1;
	}
	else
	{
	}

	cout << "LEFT:" << left << "\n";
	return left;
}

bool valid(ll x)
{
	string a = to_string(x);
	if(a.length() % 2 == 1) 
	{
		if((a[floor(a.length()/2)]-'0')*2 != 10) return false;
		a.erase(a.begin()+floor(a.length()/2));
	}

	for(ll i = 0; i < a.length()/2; i++)
	{
		if((a[i]-'0')+(a[i+(a.length()/2)]-'0') != 10)
			return false;
	}
	return true; 
}

void solve(ll tc)
{
	// 1 9 9 81 81 729 729 6561 .... pattern from no. digits
	vector<ll> cnt_digits(101,0); // maps no. digits to number of upside-down numbers
	cnt_digits[1] = 1;
	cnt_digits[2] = 9;
	for(ll i = 3; i <= 100; i++)
	{
		if(i % 2 == 1)
			cnt_digits[i] = cnt_digits[i-1];
		else
			cnt_digits[i] = cnt_digits[i-1]*9;
	}


	ll n; cin >> n;

	// map n to digit size
	ll num_digits = 0;
	ll num_iter = 0;
	ll tmp_c = 0;
	for(ll i = 1; i <= 100; i++)
	{
		tmp_c += cnt_digits[i];
		if(tmp_c >= n)
		{
			tmp_c -= cnt_digits[i];
			num_digits = i;
			cout << tmp_c << "  " << n << "\n";
			num_iter = n-tmp_c;
			break;
		}
	}
	cout << num_digits << "\n";
	cout << num_iter << "\n\n";
	if(n==1) {
		cout << "5\n";
		return;
	}
	cout << flush;
	string out(num_digits,'0');
	for(ll i = 0; i < floor(num_digits/2); i++)
		out[i] = '1';

	if(num_digits%2)//odd
	{
		out[floor(num_digits/2)] = '5';
		for(ll i = 0; i < num_iter; i++)
		{
			string tmp_left = out.substr(0,floor(num_digits/2));
			string tmp_right = "";

			if(i!=0)
			tmp_left = to_string(stoi(tmp_left)+1);

			bool skip = false;
			for(auto j : tmp_left)
				if(j == '0'){
					skip = true; break;}
			if(skip){
				while(skip)
				{
					tmp_left = to_string(stoi(tmp_left)+1);
					skip = false;
					for(auto j : tmp_left)
						if(j == '0'){
							skip = true; break;
						}
				}
			}

			/*stringstream ss;
			ss << setw(floor(num_digits/2)) << setfill('0') << tmp_left;
			tmp_left = ss.str();*/

			for(auto j : tmp_left)
			{
				ll opposite = 10-(j-'0');
				tmp_right.insert(tmp_right.begin(),'0'+opposite);
			}
			out = tmp_left + '5' + tmp_right; 
		}
	}
	else
	{
		for(ll i = 0; i < num_iter; i++)
		{

			string tmp_left = out.substr(0,num_digits/2);
			string tmp_right = "";

			if(i!=0)
			tmp_left = to_string(stoi(tmp_left)+1);

			bool skip = false;
			for(auto j : tmp_left)
				if(j == '0'){
					skip = true; break;}
			if(skip){
				while(skip)
				{
					tmp_left = to_string(stoi(tmp_left)+1);
					skip = false;
					for(auto j : tmp_left)
						if(j == '0'){
							skip = true; break;
						}
				}
			}


			/*stringstream ss;
			ss << setw(num_digits/2) << setfill('0') << tmp_left;
			tmp_left = ss.str();*/
			//cout << tmp_left << "\n";
			for(auto j : tmp_left)
			{
				ll opposite = 10-(j-'0');
				tmp_right.insert(tmp_right.begin(),'0'+opposite) ; 
			}
			out = tmp_left + tmp_right; 
		}
	}
	cout << out << "\n";
}


```