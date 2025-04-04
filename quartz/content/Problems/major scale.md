# major scale
---
>[!summary] UVA 10528. A medium [[ad hoc]] problem that is made tedious with its unnecessarily strict input requirements. Took around 1 hour


# Explanation
---
This problem can just be solved using [[Brute force]]. This can be done by permuting the unique set of notes in the input against each of the possible 12 major scales and checking if our unique set of notes is a **subset** of that major scale. If this is the case we can add the scale key to our list of valid major scales.  A decent amount of [[string]] manipulation is needed.
# Code
---
```cpp
void solve(string inp)
{
	unordered_map<string, float> notemap;
	notemap["C" ] = 0;
	notemap["C#"] = 0.5;
	notemap["D" ] = 1;
	notemap["D#"] = 1.5;
	notemap["E" ] = 2;
	notemap["F" ] = 2.5;
	notemap["F#"] = 3;
	notemap["G" ] = 3.5;
	notemap["G#"] = 4;
	notemap["A" ] = 4.5;
	notemap["A#"] = 5;
	notemap["B" ] = 5.5;

	unordered_map<float, string> freqmap;
	freqmap[0  ] = "C" ;
	freqmap[0.5] = "C#";
	freqmap[1  ] = "D" ;
	freqmap[1.5] = "D#";
	freqmap[2  ] = "E" ;
	freqmap[2.5] = "F" ;
	freqmap[3  ] = "F#";
	freqmap[3.5] = "G" ;
	freqmap[4  ] = "G#";
	freqmap[4.5] = "A" ;
	freqmap[5  ] = "A#";
	freqmap[5.5] = "B" ;

	vector<vector<float>> keys;
	for(float i = 0; i <= 5.5; i+= 0.5){
		vector<float> key = {i};
		key.pb(i+1);
		key.pb(i+2);
		key.pb(i+2.5);
		key.pb(i+3.5);
		key.pb(i+4.5);
		key.pb(i+5.5);
		for(int j = 0; j < 7; j++){
			if(key[j] > 5.5) key[j] -= 6;
		}
		keys.pb(key);
	}

	set<string> notes;

	stringstream ss(inp);
	string tmp;
	while(ss >> tmp)
	{
		notes.insert(tmp);
	}


	vector<float> deltas = {};
	for(auto i : notes)
	{
		deltas.pb(notemap[i]);
	}

	sort(deltas.begin(), deltas.end());

	vector<float> out;
	for(int i = 0; i < 12; i++){
		bool matching = true;
		for(int j = 0; j < deltas.size(); j++){
			if(find(keys[i].begin(),keys[i].end(),deltas[j]) == keys[i].end()){
				matching = false;
				break;
			}
		}
		if(matching){
			out.pb((float)i/2.0f);
		}
	}

	sort(out.begin(), out.end());
	if(!out.empty()){
		for(int i = 0; i < out.size()-1; i++){
			cout << freqmap[out[i]] << " ";
		}
		cout << freqmap[out.back()];
	}
	cout << endl;
}
```