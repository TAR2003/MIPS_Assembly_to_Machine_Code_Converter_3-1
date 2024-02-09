#include <iostream>
using namespace std;

class info
{
public:
    string name, type;
    info(string name, string type)
    {
        this->name = name;
        this->type = type;
    }
    string getType()
    {
        return this->type;
    }
};