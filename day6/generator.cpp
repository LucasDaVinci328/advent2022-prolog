#include <iostream>           // std::cout 
#include <stdio.h>
using namespace std;

int main() {
    /*
    for(int i = 1; i <= 14; ++i) {
        cout<<"A"<<i<<", ";
    }
    cout<<endl;
    */
    
    int N = 14;
    
    for (int i = 1; i <= N; ++i) {
        for (int j = 1; j < i; ++j) {
            cout<<"not_equal(";
            for(int a = 1; a <= N; ++a) {
                if(a == i || a == j) cout<<"A";
                else cout<<"_";
                if(a != N) cout<<", ";
            }
            cout<<") :- !, fail.\n";
        }
    }
}
