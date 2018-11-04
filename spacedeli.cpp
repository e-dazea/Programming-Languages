#include <iostream> 
#include <new>
#include <queue>
#include <fstream>
#include <string>
#include <cstdlib>
#include <sstream>
#include <stack>

using namespace std;

struct position{
bool loaded;
int mikos;
int platos;  
int cost;
};

struct geiasas{ 
char mov;
int ai;
int jei;
int costos=-1;
};


//operator that compares the elements of the queue, by cost and knows the one with the smallest cost
bool operator<(const position& a, const position& b) {
        // return "true" if "p1" is ordered before "p2", for example:
        return a.cost > b.cost;
};

priority_queue<struct position> q;

//fills prev array
int neighbors (struct geiasas ***prev, char g, int i, int j, bool loaded, int cost, int w, int z ) {
	int e;
	struct position q_element;
	if(g == 'W') {loaded = !loaded;
		cost++; }
	else if(loaded) cost = cost + 2;
	else cost++;
	if(loaded) e=0;
	else e=1;
	if (prev[i][j][e].costos == -1 || prev[i][j][e].costos > cost) { 
						prev[i][j][e].ai = w;
						prev[i][j][e].jei = z;
						prev[i][j][e].mov = g;
						prev[i][j][e].costos = cost;  
						q_element.mikos = i;
						q_element.platos = j;
						q_element.cost = cost;
						q_element.loaded = loaded;
						q.push(q_element); }
				
return 5;
}

int main(int argc, char** argv) {	
//declarations
int k=0,l=0,i,j,w,z;
struct position init, start;
stack<char> st;
int mikos1,platos1;

	
//attempt to open file	
ifstream myfile (argv[1], ios::in);
if (!myfile.is_open()) {
 cout << "error: unable to open file" << endl;
 exit (2);
}

queue <string> aaa;
string a;
getline(myfile,a);
aaa.push(a);
l=a.length();
while(!myfile.eof()){
	k++;
	getline(myfile,a);
	aaa.push(a);
	} //read the text file once, save the map in queue aaa (each row as a string, a)
//create the array where the map will be stored
 //giati to getline diavazei to \n ara exoume kata 1 megalutero length
 // gia na diavazei kai thn teleftaia grammh
char** eimaiOxartis = new(nothrow) char* [k]; 
for(i=0; i<k; i++) eimaiOxartis[i] = new(nothrow) char [l];

for(i=0; i<k; i++){
	a=aaa.front(); //move the map from the queue to the array
	aaa.pop(); //get row
	j=0;
	stringstream ssin(a); //divide row in chars, put in eimaiOxartis[i][j]
	while (ssin.good() && j<l){
	ssin >> eimaiOxartis[i][j];
	if(eimaiOxartis[i][j]=='S') { //keep the 'S' position (Lakis starts from there)
		start.mikos = i;
		start.platos = j;
		start.loaded = true;
		start.cost = 0;}
	j++; }
}

//create array prev
struct geiasas ***prev = new(nothrow) struct geiasas** [k];
for(i=0; i<k; i++){
	prev[i] = new(nothrow) struct geiasas* [l];
	for(j=0; j<l; j++)
	prev[i][j] = new(nothrow) struct geiasas [2]; }

init = start;
q.push(init);
prev[init.mikos][init.platos][0].mov ='S';
prev[init.mikos][init.platos][0].ai = -1;
prev[init.mikos][init.platos][0].jei = -1;
prev[init.mikos][init.platos][0].costos = 0;

int g;
while(!q.empty()) {
	init = q.top(); // get the element with the least cost
	q.pop(); // remove it from queue
	if (eimaiOxartis[init.mikos][init.platos]=='E' && init.loaded) { //if Lakis reached his destination
		mikos1 = init.mikos;
		platos1 = init.platos;
		cout << prev[mikos1][platos1][0].costos << ' ';
		int e=0;
		while(prev[mikos1][platos1][e].mov != 'S') {
			st.push(prev[mikos1][platos1][e].mov);
			if (prev[mikos1][platos1][e].mov == 'W') {
				if (e==0) e=1;
				else e=0;
			st.push(prev[mikos1][platos1][e].mov); }
			g=mikos1;
			mikos1 = prev[mikos1][platos1][e].ai;
			platos1 = prev[g][platos1][e].jei;
			
		}
		while( !st.empty() ) {
			cout << st.top();
			st.pop();
		}
	cout << '\n';
	break;
	}
	else { // if Lakis hasn't reached his destination
		//check left block, unless j=0 (can't go any lefter) or it is an obstacle
		if(init.platos!=0 && eimaiOxartis[init.mikos][init.platos-1]!='X') { 
				w = init.mikos;
				z = init.platos-1; 
				neighbors (prev,'L', w, z, init.loaded, init.cost, init.mikos, init.platos );
		}
		//check right block, unless j=l-1 (can't go any righter) or it is an obstacle
		if(init.platos!= l - 1 && eimaiOxartis[init.mikos][init.platos + 1]!='X') { 
				w = init.mikos;
				z = init.platos+1;
				neighbors (prev,'R', w, z, init.loaded, init.cost, init.mikos, init.platos  );
		}
		//check upper block, unless i=0 (can't go any upper) or it is an obstacle
		if(init.mikos!=0 && eimaiOxartis[init.mikos-1][init.platos]!='X') { 
				w = init.mikos-1;
				z = init.platos; 
				neighbors (prev,'U', w, z,  init.loaded, init.cost, init.mikos, init.platos  );
		}
		//check lower block, unless i=k-1 (can't go any lower) or it is an obstacle
		if(init.mikos!=k-1 && eimaiOxartis[init.mikos+1][init.platos]!='X') { 
				w = init.mikos+1;
				z = init.platos;
				neighbors (prev,'D', w, z, init.loaded, init.cost, init.mikos, init.platos  );
				
		}
		//if it is a wormhole
		if(eimaiOxartis[init.mikos][init.platos] == 'W') {
				neighbors (prev,'W', init.mikos, init.platos, init.loaded, init.cost, init.mikos, init.platos); 
		}
	}
}
	
//free memory
for(i=0; i<k;i++){
	for (j=0; j<l; j++) {
		delete[] prev[i][j]; 
	}
}
for (i=0; i<k; i++) {
	delete[] prev[i];
	delete[] eimaiOxartis[i]; 
}
delete[] eimaiOxartis;
delete[] prev;


myfile.close();	
return 0;
}
