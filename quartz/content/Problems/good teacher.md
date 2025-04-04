# good teacher
---
>[!summary] UVA 12662. Relatively simple problem. Took around 30 minutes


# Explanation
---
You will just need to keep spanning outwards, performing a *search* in either direction until you find a valid letter. If you find 2 letters in the same distance you use `middle of`. 
# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	vector<string> arr(n);
	for(int i = 0; i < n; i++) {
		cin >> arr[i];
	}

	int q; cin >> q;
	for(int i = 0; i < q; i++) {
		int idx; cin >> idx;
		idx--;
		if(arr[idx] != "?"){
			cout << arr[idx] << endl;
			continue;
		}

		int dist = 1;
		while(true){
			if((idx+dist < n and arr[idx+dist] != "?") or (idx-dist >= 0 and arr[idx-dist] != "?")){
				break;
			}
			dist++;
		}
		if((idx+dist < n and arr[idx+dist] != "?") and (idx-dist >= 0 and arr[idx-dist] != "?")){
			cout << "middle of " << arr[idx-dist] << " and " << arr[idx+dist] << endl;
		}
		else if(idx+dist < n and arr[idx+dist] != "?"){
			for(int j = 0; j < dist; j++)
				cout << "left of ";
			cout << arr[idx+dist] << endl;

		}
		else if(idx-dist >= 0 and arr[idx-dist] != "?"){
			for(int j = 0; j < dist; j++)
				cout << "right of ";
			cout << arr[idx-dist] << endl;
		}
		
	}


}
```