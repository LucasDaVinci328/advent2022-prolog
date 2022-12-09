#include <fstream>
#include <string>
#include <iostream>

using namespace std;

int main () {
        fstream fin;
        fin.open("rucksacks.txt");

        while(!fin.eof()) {
                string s;
                fin>>s;
                cout<<'"'<<s<<'"'<<' ';
        }
        return 0;
}
