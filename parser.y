%{
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <math.h>
#include <unordered_map>
#include "info.cpp"
using namespace std;
extern int yylex();
extern int yyparse();
extern int er;
extern FILE* yyin;
int line = 0;
string z = "0";
string t0 = "1";
string t1 = "2";
string t2 = "3";
string t3 = "4";
string t4 = "5";
string sp = "6";

ofstream outFile("machine_code.txt");
unordered_map<string, int> map;

string toBinary(string num, int bits)
{

    int n = stoi(num);
    int temp = n;
    // cout << n << endl;
    int b = bits;
    string v = "";
    if (n < 0)
    {
        n = pow(2, bits) + n;
    }
    // cout << n << endl;
    while (bits--)
    {
        int temp = n % 2;
        n /= 2;
        v.push_back((temp + '0'));
    }
    for (int i = 0; i < b / 2; i++)
    {
        swap(v[i], v[b - i - 1]);
    }
    return v;
}

string toHex(string str)
{
    string hex = "";
    for (int i = 0; i < str.size(); i += 4)
    {
        string temp = str.substr(i, 4);
        if (temp == "0000")
        {
            hex += "0";
        }
        else if (temp == "0001")
        {
            hex += "1";
        }
        else if (temp == "0010")
        {
            hex += "2";
        }
        else if (temp == "0011")
        {
            hex += "3";
        }
        else if (temp == "0100")
        {
            hex += "4";
        }
        else if (temp == "0101")
        {
            hex += "5";
        }
        else if (temp == "0110")
        {
            hex += "6";
        }
        else if (temp == "0111")
        {
            hex += "7";
        }
        else if (temp == "1000")
        {
            hex += "8";
        }
        else if (temp == "1001")
        {
            hex += "9";
        }
        else if (temp == "1010")
        {
            hex += "a";
        }
        else if (temp == "1011")
        {
            hex += "b";
        }
        else if (temp == "1100")
        {
            hex += "c";
        }
        else if (temp == "1101")
        {
            hex += "d";
        }
        else if (temp == "1110")
        {
            hex += "e";
        }
        else if (temp == "1111")
        {
            hex += "f";
        }
        else {
            cout << "invalid" << endl;
        }
    }
    return hex;
}

string process(string str)
{
    if (str.compare("$zero") == 0)
    {
        return z;
    }
    else if (str.compare("$t0") == 0)
    {
        return t0;
    }
    else if (str.compare("$t1") == 0)
    {
        return t1;
    }
    else if (str.compare("$t2") == 0)
    {
        return t2;
    }
    else if (str.compare("$t3") == 0)
    {
        return t3;
    }
    else if (str.compare("$t4") == 0)
    {
        return t4;
    }
    else if (str.compare("$sp") == 0)
    {
        return sp;
    }
    else
    {
        return toHex(toBinary(str, 4));
    }
}
string ans = "";
void processString() {
    string answer = "";
    int curline = 0;
    for(int i  = 0 ; i < ans.size() ; i++) {
        if(ans[i] == '$') {
            string temp = "";
            i++;
            while(ans[i] != '$') {
                temp += ans[i];
                i++;
            }
            int t = map[temp];
            t = t - curline - 1;
            answer += process(to_string(t));
            //i++;

        }
        else if(ans[i] == '|') {
            string temp = "";
            i++;
            while(ans[i] != '|') {
                temp += ans[i];
                i++;
            }
            int t = map[temp];
            string tmp = toBinary(to_string(t), 8);
            answer += (toHex(tmp.substr(0,4)));
            answer += (toHex(tmp.substr(4,8)));
            // if(tmp.size() == 1) {
            //     tmp = "0" + tmp;
            // }
            //i++;

        }
        else {
            answer += ans[i];
            if(ans[i] == '\n') curline++;
        }
    }
    outFile << answer << endl;
}
void yyerror(const char* s) {
    fprintf(stderr, "it is a %s\n", s);
    //exit(0);
}



%}



%union {
    struct obj {
    int line;
    const char * str;
    info *stinfo;
    }ob1;
}

%token <ob1> ADD ADDI SUB SUBI OR ORI AND ANDI NOR SLL SRL LW SW BEQ BNEQ J PUSH POP COMMA REG LPAREN RPAREN LEVEL COLON  NUMBER
%type start program unit stat 


%%
start : program
;
program : 
        | program unit
;
unit : LEVEL COLON {
    //cout << "LEVEL COLON" << endl;
    map[$1.stinfo->getType()] = line;
    
}
     | stat {}
     ;
stat : ADD REG COMMA REG COMMA REG {
//cout << "ADD REG COMMA REG COMMA REG" << endl;
ans += "0";
ans += process($4.stinfo->getType());
ans += process($6.stinfo->getType());
ans += process($2.stinfo->getType());
ans += '\n';

line++;
}
     | ADDI REG COMMA REG COMMA NUMBER {
        ans += "8";
        ans += process($4.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += '\n';
        //cout << "ADDI REG COMMA REG COMMA NUMBER" << endl;
        line++;
     }
     | SUB REG COMMA REG COMMA REG {
        //cout << "SUB REG COMMA REG COMMA REG" << endl;
        
        ans += "9";
        ans += process($4.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += '\n';
        line++;
     }
     | SUBI REG COMMA REG COMMA NUMBER {
        //cout << "SUBI REG COMMA REG COMMA NUMBER" << endl;
        ans += "5";
        ans += process($4.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += '\n';
        line++;
     }
     | OR REG COMMA REG COMMA REG {
        //cout << "OR REG COMMA REG COMMA REG" << endl;
        ans += "C";
        ans += process($4.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += '\n';
        line++;
     }
     | ORI REG COMMA REG COMMA NUMBER {
        //cout << "ORI REG COMMA REG COMMA NUMBER" << endl;
        ans += "3";
        ans += process($4.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += '\n';
        line++;
        }
     | AND REG COMMA REG COMMA REG {
        //cout << "AND REG COMMA REG COMMA REG" << endl;
        ans += "2";
        ans += process($4.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += '\n';
        line++;
     }
     | ANDI REG COMMA REG COMMA NUMBER {
        //cout << " ANDI REG COMMA REG COMMA NUMBER" << endl;
        ans += "E";
        ans += process($4.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += '\n';
        line++;
     } 
     | NOR REG COMMA REG COMMA REG {
        //cout << "NOR REG COMMA REG COMMA REG" << endl;
        ans += "1";
        ans += process($4.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += '\n';
        line++;
     }
     | SLL REG COMMA REG COMMA NUMBER {
        //cout << " SLL REG COMMA REG COMMA NUMBER " << endl;
        ans += "F";
        ans += process($4.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += '\n';
        line++;
     }
     | SRL REG COMMA REG COMMA NUMBER {
        //cout << "SRL REG COMMA REG COMMA NUMBER" << endl;
        ans += "6";
        ans += process($4.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($6.stinfo->getType());
        ans += '\n';
        line++;
     }
     | LW REG COMMA NUMBER LPAREN REG RPAREN {
        //cout << "LW REG COMMA NUMBER LPAREN REG RPAREN" << endl;
        ans += "D";
        ans += process($6.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($4.stinfo->getType());
        ans += '\n';
        line++;
     }
     | SW REG COMMA NUMBER LPAREN REG RPAREN {
        //cout << "SW REG COMMA NUMBER LPAREN REG RPAREN" << endl;
        ans += "B";
        ans += process($6.stinfo->getType());
        ans += process($2.stinfo->getType());
        ans += process($4.stinfo->getType());
        ans += '\n';
        line++;
     }
     | BEQ REG COMMA REG COMMA LEVEL {
        //cout << "BEQ REG COMMA REG COMMA LEVEL" << endl;
        ans += "A";
        ans += process($2.stinfo->getType());
        ans += process($4.stinfo->getType());
        ans += "$" + $6.stinfo->getType() +"$";
        ans += '\n';
        line++;
     }
     | BNEQ REG COMMA REG COMMA LEVEL {
        //cout << "BNEQ REG COMMA REG COMMA LEVEL" << endl;
        ans += "7";
        ans += process($2.stinfo->getType());
        ans += process($4.stinfo->getType());
        ans += "$" + $6.stinfo->getType() +"$";
        ans += '\n';
        line++;
     }
     | J LEVEL {
        //cout << "J LEVEL" << endl;
        ans += "4";
        ans += ("|" + $2.stinfo->getType() + "|");
        ans += "0";
        ans += '\n';
        line++;
     }
     | PUSH REG {
        //cout << "PUSH REG" << endl;
        ans += "B6" + process($2.stinfo->getType()) + "0\n"; 
        ans += "5661";
        ans += '\n';
        line+=2;
     }
     | POP REG {
        //cout << "POP REG" << endl;
        
        ans += "8661";
        ans += '\n';
        ans += "D6" + process($2.stinfo->getType()) + "0\n"; 
        line+=2;
     }
     
     | PUSH NUMBER LPAREN REG RPAREN {
        //ans += 
        //ans += 
        ans += "D";
        ans += process($4.stinfo->getType());
        ans += "7";
        ans += process($2.stinfo->getType());
        ans += '\n';
        ans += "B670\n"; 
        ans += "5661";
        ans += '\n';
        line+=3;

     }
;



%%

main(int argc, char *argv[])
{
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        exit(1);
    }
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Failed to open input file");
        exit(1);
    }
    outFile << "v2.0 raw" << endl;

    yyparse();
    
    processString();
    exit(0);
}


