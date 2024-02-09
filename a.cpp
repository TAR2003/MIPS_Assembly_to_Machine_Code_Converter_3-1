#include <iostream>
#include <unordered_map>
#include <math.h>

using namespace std;

int main()
{
    unordered_map<string, int> s;
    s["hello"] = 3;
    cout << s["hello"] << endl;
}