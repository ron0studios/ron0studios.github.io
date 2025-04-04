# stable groups
---
>[!summary] pretty hard codeforces problem


# Explanation
---
This is a [[Greedy]] problem that requires a decent level of [[sorting]].

Essentially you first start by sorting the `students` . This guarantees that you can group together that are the same value or are close. 

You then can calculate the gaps between each of the elements and sort this too, so we can start computing based on the smallest gaps that are bigger than `x` first.

We start by precomputing the number of groups in the beginning, without adding any of the `k` students. We can then change this value later on. 

Essentially for each of the gaps, if the gap is bigger than x (meaning that it cannot be part of a group), then we check how many `k` students we need to fill that gap, using math. 
We then check, is this gap something that can be filled by the `k` students we have left? If not, we continue through the gaps, because adding them will not effect the group numbers in any way and would be a waste. If this is the case then we remove the number of students needed and substract 1 from the current number of groups possible^[as we have technically joined together two groups, similar to the concept of the [[Union-find structure]]]

Once we have done this, we will have solved the problem. This problem is limited by the speed of your sorting algorithm and is therefore $\pmb{\mathcal{O}(Nlog(N))}$     

# Code
---
```cpp
void solve()
{
	ll n,k,x; cin >> n >> k >> x;
	vector<ll> students(n,0);
	
	for(ll i = 0; i < n; i++)
	{
		cin >> students[i];
	}
	sort(students.begin(), students.end());
	
	vector<pair<ll,ll>> gaps;
	for(ll i = 1; i < n; i++)
	{
		gaps.pb({students[i]-students[i-1], i});
	}
	
	sort(gaps.begin(), gaps.end());
	ll out = 1; 
	for(ll i = 1; i < n; i++)
	{
		if( students[i] - students[i-1] > x)
			out++;
	}
	
	for(auto i : gaps)
	{
		if(i.first <= x) continue;
		if(k==0) break;
		ll gap = i.first-1;
		ll cnt = floor(gap/(float)x);
		if(cnt > k) break;
		k -= cnt;
		out--;
	}
	
	cout << out << endl;
}
```