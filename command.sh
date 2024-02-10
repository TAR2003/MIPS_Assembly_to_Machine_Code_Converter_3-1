clear #
yacc -d -y parser.y #
g++ -w -c -o y.o y.tab.c #
flex lex.l #
g++ -w -c -o l.o lex.yy.c #
g++ y.o l.o -lfl -o file # #
./file input.asm #
