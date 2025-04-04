# substring removal
---
>[!summary] a codeforces substring problem with a neat trick


# Explanation
---
This question is a pretty difficult strings problem if you don't do that many substring problems (me). 

The thing to notice here is that a substring removed from a string, leaving nothing but the same letter, is only possible if the substring is taken from the middle, the beginning or the end. 

Hence we have to calculate the length of the prefix and suffix of the string where the same continuous letter is used.

If the suffix and prefix substrings contain different letters then the total combinations will be equal to $$\LARGE{\text{pre} + \text{suf} + 1}$$
This is because there are `pre` substrings that leave behind the same characters (that are all s\[0\] ). There are `suf` substrings that leave behind the same characters (that are all s\[-1\] ), and there is 1 substring that represents the entire string as the substring

If the suffix and prefix substrings contain *the same* letter, then the total combinations will be equal to $$\LARGE{1 + pre + suf + suf\times pre}$$
think about the example $\LARGE{aacdaaa}$.
$$
\Large{
	\displaylines{
		\text{cd} \\
		\text{acd} \\
		\text{aacd} \\
		\text{cda} \\
		\text{cdaa} \\
		\text{cdaaa} \\
		\text{acda} \\
		\text{acdaa} \\
		\text{acdaaa} \\
		\text{aacda} \\
		\text{aacdaa} \\
		\text{aacdaaa} \\ \\
		\text{TOTAL = 12}
	}
}
$$
There's 1 substring, where you remove the middle, `cd`. 
There's `pre` substrings, which remove the first `pre` letters, `acd` and `aacd`
There's `suf` substrings, which remove the last `suf` letters, `cda`, `cdaa`, and `cdaaa`

And what's leftover are all the mixes of the two, e.g removing 1 from pre, and 1 from suf, then 1 from pre, 2 from suf, then 1 from pre 3 from suf, and then 2 from pre and so on.

# Code
---
```cpp
void solve()
{
	const ll mod = 998244353;
	ll n; cin >> n;
	string s; cin >> s;
	ll pre = 1;
	ll suf = 1;

	for(int i = 1; i < n; i++)
		if(s[i] == s[i-1]) pre++;
		else break;
	for(int i = n-1; i > 0; i--)
		if(s[i] == s[i-1]) suf++;
		else break;

	ll ans;

	if(s[0] != s.back()) {
		ans = (1 + pre + suf);
		ans = ans%mod;
	}
	else {
		ans = 1+min(pre,suf)+max(pre,suf)+( min(pre,suf)*max(pre,suf) );
		ans = ans%mod;
	}
	cout << ans << "\n";
}
```