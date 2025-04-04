# Snapper (hard)
---
>[!summary] kattis-snapperhard. A pretty easy [[bitwise operations]] problem. Took around 30 mins


# Explanation
---
Once you spot the pattern you'll notice each snap changes the snapper values in the manner of a binary sequence, i.e. 0, 1, 10, 11, 100, 101, 110, 111 ....

The Nth snapper is only active if all previous snappers are also 1, in order to feed the Nth snapper its power. Therefore we need to **mask** the value of K with 1111111 and check if there is a match.

# Code
---
```cpp
void solve(int tc)
{
	ll n, k; cin >> n >> k;
	bool o = ((k&((1<<n)-1))==(1<<n)-1);
	cout << "Case #" << tc << ": " << (o ? "ON" : "OFF") << endl;
}
```