# Indexed Priority Queue
An indexed priority queue is a versatile data structure that combines both the p-queue and a [[hash map]] into one. Since regular priority queues are essentially trees, then the time complexity of searching to find a particular node is *O(N)* , which is generally quite slow. The hash map aspect converts each item into a key value pair, creating a quick **O(1)** lookup time. There is also the benefit that you will not get duplicate keys. 

As an example, an indexed priority queue would be very useful in the case of [[Dijkstra]], since it is often the case that you can find duplicate items in the queue that have already been visited. With an indexed system, you can resolve this by maintaining a single key value pair, reducing the value instead of creating a duplicate.

Priority queues can be further improved by changing the number of children a heap node can have, using [[priority queue#D-ary priority queues]], which reduces the log component from log2 to logE/V, where D should be E/V. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/jND_WJ8r7FE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Inner Workings 

An indexed priority queue uses, at its core, a classic [[heap]] implementation, as an array where finding the left and right child of any node can be done with the equations:
$$Leftnode = 2i+1$$
$$Rightnode = 2i+2$$
where **i** is the index of the node in the heap, in the array.

Past this, we have a set of numbers that represent the key of the node^[remember that in an indexed priority queue, data is stored as key value pairs]. In most cases, we can just number them 1 to N. These are known as the key-indexes

For each of the key-indexes, we need to map the value associated with them^[Notice how we have not yet actually begun integrating the data with the heap yet]. This should be provided with your input data. 

Now we can begin integrating with the heap itself. We map our key-indexes to another set of values, which is known as the position map. This maps the key indexes to its respective index in the heap array. 

We will also need another map which can do the opposite. We will need to be able to map any position in the heap to its respective key-index. This will be known as the index map.

With this information about the data structure, implementing the indexed priority queue should be similar to that of a regular priority queue.

## Insertion
Insertion is pretty much the same as a regular priority queue heap. You increase the array size of the heap by 1 (i.e go to the bottom right-most node in the heap) and create a new node with the values provided (key index and value) to the *new* bottom rightmost node. 

You then swim up the heap until you find a suitable spot. Update the index and position map accordingly

## Polling/Removal
replace the node to be removed with the bottom rightmost node (i.e the end of the heap array). Then, swim up or down that node until the heap invariant is gone, which can be done by calling both functions one after the other.

## Implementation
This took way too long (2-3 days), Priority queues are the devil. 
```c++
class IPQ
{
	public:

		// 0-based indexing for the key-indexes
		IPQ(vector<int> values = vector<int>())
		{
			size = values.size();
			for(unsigned int i = 0; i < values.size(); i++)
			{
				insert(i,values[i]);
			}
		}

		void insert(int key, int value)
		{
			// add node to bottom right of heap
			val[key] = value;
			pm[key] = size;
			im[size] = key;

			//swim
			swim(size);
			size++;
		}

		pair<int,int> pop()
		{
			pair<int,int> x = mp(im[0], val[im[0]]);
			remove(im[0]); // logn
			return x;
		}

		void remove(int key)
		{
			int pos = pm[key];
			swap(pos,size-1);
			size--;

			val.erase(key);
			pm.erase(key);
			im.erase(size);

			sink(pos);
			swim(pos);


			
		}

		void printheap() 
		{
			for(auto i : im){
				cout << i.first << ":  ";
				cout << i.second  << ":" << val[i.second] << "\n";
			}
		}


		
		int size = 0;
	private:
		unordered_map<int,int> val; // ki : val
		unordered_map<int,int> pm; // ki : index
		unordered_map<int,int> im; // index : ki
	
	private:
		
		void swap(int i, int j)
		{
			pm[im[j]] = i;
			pm[im[i]] = j;
			int tmp = im[i];
			im[i] = im[j];
			im[j] = tmp;
		}
		
		void sink(int node) // heap index
		{
			while(true)
			{
				int left = (2*node)+1;
				int right = (2*node)+1;
				int smallest;

				if(left >= size)
					smallest = right;
				else if(right >= size)
					smallest = left;
				else
					smallest = (val[im[left]] < val[im[right]]) ? left : right;


				if(left>=size && right>=size)
					break;
				
				if(val[im[smallest]] >= val[im[node]])
					break;


				swap(smallest,node);
				node = smallest;

			}
		}

		void swim(int node) // heap index
		{
			int i = floor((node-1)/2);
			while(i >= 0 && val[im[node]] < val[im[i]])
			{
				swap(i,node);
				node = i;
				i = floor((node-1)/2);
			}
		}
};
```