#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
using namespace std;

class SymbolInfo
{
private:
    SymbolInfo *nextSymbolInfo;
    string name, type, returntype;
    int x, y;
    string sid;

public:
    SymbolInfo *parameters;
    string arrayType;
    bool defined;
    SymbolInfo(string n, string t)
    {
        name = n;
        type = t;
        nextSymbolInfo = NULL;
        returntype = "";
        arrayType = "";
        defined = true;
    }
    SymbolInfo(string n, string t, string rtype)
    {
        name = n;
        type = t;
        nextSymbolInfo = NULL;
        returntype = rtype;
        arrayType = "";
        defined = false;
    }
    SymbolInfo(const SymbolInfo &s)
    {
        name = s.name;
        type = s.type;
        returntype = "";
        setNextSymbolInfo(s.nextSymbolInfo);
    }

    ~SymbolInfo()
    {
        if (nextSymbolInfo)
            delete nextSymbolInfo;
    }
    string getName()
    {
        return name;
    }
    string getType()
    {
        return type;
    }
    string getreturntype()
    {
        return returntype;
    }
    SymbolInfo *getNextSymbolInfo() { return nextSymbolInfo; }
    void setNextSymbolInfo(SymbolInfo *s)
    {
        SymbolInfo *stemp = this;
        while (stemp->nextSymbolInfo != NULL)
        {
            stemp = stemp->nextSymbolInfo;
        }
        stemp->nextSymbolInfo = s;
    }
    void setreturntype(string r)
    {
        returntype = r;
    }
    string print()
    {
        string str = ("");
        str.append("<");
        str = str + name + "," + type;
        if (returntype.length() > 0)
            str += "," + returntype;
        str += "> ";
        if (nextSymbolInfo != NULL)
            return str + nextSymbolInfo->print();
        else
            return str;
    }
    // int getX() { return x; }
    // int getY() { return y; }
    // string getSid() { return sid; }
    // void setX(int j) { x = j; }
    // void setY(int j) { y = j; }
    // void setSid(string id) { sid = id; }
};
