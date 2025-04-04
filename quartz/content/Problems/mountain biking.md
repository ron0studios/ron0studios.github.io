# mountain biking
---
>[!summary] CF gym 100800B. Simple [[maths]] problem, took around 10-20 minutes.


# Explanation
---
Just need to use **SUVAT** $v^2=u^2+2as$ to calculate the velocities through each slope.

# Code
---
```cpp
void solve()
{
	int n; cin >> n;
	double g; cin >> g;

	vector<pair<double, double>> slopes(n, mp(0,0));
	for(int i = 0; i < n; i++)
		cin >> slopes[i].first >> slopes[i].second;

	vector<double> out(n, 0.0);
	for(int i =0; i < n; i++){
		double u = 0.0;
		for(int j =i; j < n; j++){
			double accel = g*cos(slopes[j].second * (M_PI / 180));
			u = sqrt(u*u + 2.0*accel*slopes[j].first);
		}
		out[i] = u;
	}

	for(int i = 0; i < n; i++){
		cout << setprecision(15) <<  out[i] << endl;
	}

}
```