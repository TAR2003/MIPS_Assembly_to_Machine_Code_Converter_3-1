%option noyywrap

%x BSTATE
%x MONOAP
%x DOUBLEAP
%x SINGLELINECOMMENT
%x MULTILINECOMMENT
%x INDENT


%{
    
//without any whitespace not working cannot read, agei read hoye jacche [indent] egua diye,
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<iostream>
#include "info.cpp"
#include "y.tab.h"
using namespace std;



    
%}
Letter[a-zA-Z]
Alphanumeric[a-zA-Z0-9_]
Numbers [0-9]
%%

"//"[^\n]+ {}
"/*"[.]+"*/" {}

"add" {return ADD;}
"addi" { return ADDI;}
"sub" {return SUB;}
"subi" {return SUBI;}
"or" {return OR;}
"ori" {return ORI;}
"and" {return AND;}
"andi" {return ANDI;}
"sll" {return SLL;}
"srl" {return SRL;}
"nor" {return NOR;}
"sw" {return SW;}
"lw" {return LW;}
"j" {return J;}
"beq" {return BEQ;}
"bneq" {return BNEQ;}
"push" {return PUSH;}
"pop" {return POP;}

\${Alphanumeric}+ { yylval.ob1.stinfo = new info("REG",yytext);return REG;}
{Letter}{Alphanumeric}+ { yylval.ob1.stinfo = new info("LEVEL",yytext);return LEVEL;}
{Numbers}+ {yylval.ob1.stinfo = new info("NUMBER",yytext);return NUMBER;}

"(" { yylval.ob1.stinfo = new info("LPAREN", yytext);    return LPAREN;}
")" { yylval.ob1.stinfo = new info("RPAREN", yytext);    return RPAREN;}
"," {  yylval.ob1.stinfo = new info("COMMA" , yytext);    return COMMA;}
":" {  yylval.ob1.stinfo = new info("COLON", yytext); return COLON;}

[.] {}
<<EOF>> {return 0; }



%%

/* int main (int argc, char *argv[]) {
    if(argc!=2) {
        printf("pplease provide input \n");
        return 0;
    }
    FILE *fin=fopen(argv[1],"r");
    if(fin == NULL) {
        printf("Cannot open file\n");
        return 0;
    }
    yyin = fin;
    logfile = fopen("2005090_log.txt", "w");
    tokenfile = fopen("2005090_token.txt", "w");
    s = new SymbolTable(10);
    BEGIN 6;
    int c = yylex();
    printAll();
    fclose(yyin);
    fprintf(logfile, "Total lines: %d\n",lines);
    fprintf(logfile, "Total errors: %d\n", errors);
    fprintf(logfile, "Total warnings: %d\n", warnings );
    //printf("WE are done %d\n\n", c);
    fclose(tokenfile);
    fclose(logfile);
    //cout << "ALl finished here \n\n" << endl;
    return 0;
} */
