#  longest common prefix
---
>[!summary] Annoying codeforces Greedy problem


# Explanation
---
This is an annoying [[Greedy]] problem, for a similar problem check [[playing with gcd]]

I overcomplicated it by changing the sizes of each word in the array of [[string|strings]], when you could just do what the editorial did, which was to have a 200-letter word and change everything else for each word.

What i did was set $s[i+1] := s[i]$ , and then add letters if the size of the lcp in $i+1$ is bigger than the current size, or reduce it if otherwise. after that i would change a's to a+1's (mod 26) to change the matches if its too big or small.

A better solution (editorial), would be to have a 200-letter word and then for every subsequent word, flip letters between 'b' and 'a' after the longest common prefix is reached (check the code its simple to understand)

# Code
---
editorial code:
```cpp
void solve()
{
    int n;
    cin >> n;

    string s(200, 'a');
    cout << s << endl;

    for (int i = 0; i < n; ++i)
    {
        int u;
        cin >> u;
        s[u] = s[u] == 'a' ? 'b' : 'a';
        cout << s << endl;
    }
}
```
my code:
```cpp

void solve(int tc)
{
	int n; cin >> n;
	vector<int> a(n,0);
	for(int i = 0; i < n; i++)
		cin >> a[i];

	vector<string> out(n+1, ".");
	out[0] = "";
	for(int i = 0; i < max(a[0],1); i++)
		out[0] += 'a';

	for(int i = 0; i < n; i++)
	{
		if(i == n-1)
		{
			if(a[n-1] == 0)
				out[n] = string(1, 'a'+((out[i][0]-'a'+1)%26));
			else out[n] = string(out[n-1].begin(), out[n-1].begin() + a[n-1]);
		}
		else
		{
			if(a[i] == 0)
			{
				out[i+1] = string(max(max(a[i+1],1), a[i]), 'a'+((out[i][0]-'a'+1)%26));
				continue;
			}
			out[i+1] = out[i];
			while((int)out[i+1].length() != max(a[i+1],a[i]))
			{
				if((int)out[i+1].length() > max(a[i+1], a[i]))
				{
					out[i+1] = string(out[i+1].begin(), out[i+1].end()-1);
				}
				else
				{
					out[i+1] += out[i][0];
				}
			}

			if(a[i+1] > a[i] and (int)out[i].length() > a[i])
			{
				for(int j = a[i]; j < a[i+1]; j++)
				{
					out[i+1][j] = 'a'+((out[i][a[i]]-'a'+1)%26);
				}
			}


		}
	}
	for(auto i : out)
		cout << i << endl;

}
```