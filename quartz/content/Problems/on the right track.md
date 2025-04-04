#bio
# On the right track
---
> A tedious BIO 2011 Q2 problem that can pretty easily be overcomplicated [[ad hoc|implementation]]


# Explanation
---
This problem is very similar to [[Enigma machine]], where a cyclic [[graph]] allows for infinite travel between nodes. However, the difference here is the complexity of the problem, which asks to modify the edges. 

Here are ways in which I overcomplicated things:
- Using a [[graph#Node list|Node list]] representation instead of the much easier [[graph#Edge list|Edge list]] approach
- not limiting the possible 'preference' to the left and right nodes, and manually setting each preference. 

You will notice that 70% of the code here is preparation of the graph and spagghetti code!

# Code
---
```cpp

class Point {
	public:
		int type = 0; // 0: lazy, 1: flipflop
		char id; 
		char incoming;
		char left;
		char right;

		char preference;

		Point(int t, char i)
		{
			type = t;
			id = i;
		}
};

class Railway {
	public:
		vector<Point> rails; // hashmaps dont work :( 
		map<pair<char,char>, bool> curved;	
		map<pair<char,char>, bool> straight;	

		Railway(){
			for(int i = 0; i < 26; i++)
			{
				Point x(0,'A'+i);
				rails.pb(x);
			}
		}

		Point* get(char x)
		{
			return &rails[x-'A'];
		}
};

void solve(int tc)
{
	Railway rails; 

	rails.get('A')->incoming = 'D'; rails.straight[mp('D','A')] = true; 
	rails.get('D')->incoming = 'A'; rails.straight[mp('A','D')] = true;
	rails.get('B')->incoming = 'C'; rails.straight[mp('C','B')] = true;
	rails.get('C')->incoming = 'B'; rails.straight[mp('B','C')] = true;

	for(int i = 0; i < 4; i++)
	{
		rails.get('E'+(i*2))->incoming = 'A'+i;
		rails.get('E'+(i*2)+1)->incoming = 'A'+i;
		rails.get('A' + i)->left = 'E'+(i*2);
		rails.get('A' + i)->right = 'E'+(i*2)+1;

		rails.curved[mp('E'+(i*2), 'A'+i)] = true;
		rails.curved[mp('E'+(i*2)+1, 'A'+i)] = true;
		rails.straight[mp('A'+i, 'E'+(i*2))] = true; 
		rails.straight[mp('A'+i, 'E'+(i*2)+1)] = true;

		rails.get('A'+i)->preference = 'E'+(i*2); // left
	}

	for(int i = 0; i < 7; i++)
	{
		rails.get('E'+i)->left = 'M'+i;
		rails.get('E'+i)->right = 'M'+i+1;

		rails.curved[mp('E'+i,'M'+i)] = true;
		rails.curved[mp('E'+i,'M'+i+1)] = true;

		rails.get('E'+i)->preference = 'M'+i;
	}
	rails.get('L')->incoming='D';
	rails.get('L')->left='T';
	rails.get('L')->right='M';
	rails.curved[mp('L','D')] = true;
	rails.curved[mp('L','T')] = true;
	rails.curved[mp('L','M')] = true;
	rails.get('L')->preference = 'T';

	for(int i = 1; i < 8; i++)
	{
		rails.get('M'+i)->left = 'E'+i-1;
		rails.get('M'+i)->right = 'E'+i;
		rails.get('M'+i)->incoming = 'U'+floor(i/2);

		rails.curved[mp('M'+i,'E'+i-1)] = true;
		rails.curved[mp('M'+i,'E'+i)] = true;
		rails.curved[mp('M'+i, 'U'+floor(i/2))] = true;

		rails.get('M'+i)->preference = 'E'+i-1;
	}
	rails.get('M')->incoming = 'U';
	rails.get('M')->left = 'L';
	rails.get('M')->right = 'E';
	rails.curved[mp('M','L')] = true;
	rails.curved[mp('M','E')] = true;
	rails.curved[mp('M','U')] = true;
	rails.get('M')->preference = 'L';

	for(int i = 0; i < 4; i++)
	{
		rails.get('U'+i)->left =  'M'+(i*2);
		rails.get('U'+i)->right =  'M'+(i*2)+1;
		rails.straight[mp('U'+i,'M'+(i*2))] = true;
		rails.straight[mp('U'+i,'M'+(i*2)+1)] = true;

		rails.get('U'+i)->preference = 'M'+(i*2);
	}
	rails.get('U')->incoming = 'V'; rails.straight[mp('U','V')] = true;
	rails.get('V')->incoming = 'U'; rails.straight[mp('V','U')] = true;
	rails.get('W')->incoming = 'X'; rails.straight[mp('W','X')] = true;
	rails.get('X')->incoming = 'W'; rails.straight[mp('X','W')] = true;


	for(auto i : rails.rails)
	{
		cout << i.id << " ::: " << i.incoming << " " << i.left << " " << i.right << "\n";
	}

	string flippers; cin >> flippers; 
	for(auto i : flippers) 
	{
		rails.get(i)->type = 1;
	}


	pair<char,char> trainpos; 
	cin >> trainpos.first >> trainpos.second;

	int n; cin >> n;

	for(int i = 0; i < n; i++)
	{
		Point* entering = rails.get(trainpos.second); 

		if(entering->type == 0) // lazy
		{
			if(rails.curved[trainpos] == true)
			{
				rails.get(trainpos.second)->preference = trainpos.first; 
				trainpos.first = trainpos.second;
				trainpos.second = rails.get(trainpos.first)->incoming; 
			}
			else
			{
				trainpos.first = trainpos.second;
				trainpos.second = rails.get(trainpos.first)->preference;
			}
		}
		else // flip flop
		{
			if(rails.straight[trainpos] == true)
			{
				trainpos.first = trainpos.second;
				trainpos.second = rails.get(trainpos.first)->preference;  

				if(rails.get(trainpos.first)->preference == rails.get(trainpos.first)->left)
					rails.get(trainpos.first)->preference =  rails.get(trainpos.first)->right;
				else
					rails.get(trainpos.first)->preference =  rails.get(trainpos.first)->left;
			}
			else
			{
				trainpos.first = trainpos.second;
				trainpos.second = rails.get(trainpos.first)->incoming;
			}
		}
	}
	cout << trainpos.first << trainpos.second << "\n";
}


```