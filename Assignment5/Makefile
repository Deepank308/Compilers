all: 	a.out
	./a.out < ass5_17CS30011_test1.c > output1.txt
	./a.out < ass5_17CS30011_test2.c > output2.txt
	./a.out < ass5_17CS30011_test3.c > output3.txt
	./a.out < ass5_17CS30011_test4.c > output4.txt
	./a.out < ass5_17CS30011_test5.c > output5.txt
	
	@echo "\nDone...\n"

a.out:	 lex.yy.o y.tab.o ass5_17CS30011_translator.o 
	g++ lex.yy.o y.tab.o ass5_17CS30011_translator.o -lfl

y.tab.o:	y.tab.c
	g++ -c y.tab.c

lex.yy.o:	lex.yy.c
	g++ -c lex.yy.c

lex.yy.c:	ass5_17CS30011.l y.tab.c
	flex ass5_17CS30011.l 

y.tab.c:	ass5_17CS30011.y
	yacc -dtv ass5_17CS30011.y 

ass5_17CS30011_translator.o: ass5_17CS30011_translator.h ass5_17CS30011_translator.cxx
	g++ -c ass5_17CS30011_translator.cxx

clean:
	rm -f a.out y.tab.o lex.yy.o lex.yy.c y.tab.c y.tab.h y.output ass5_17CS30011_translator.o output*.txt
