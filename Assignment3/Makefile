a.out:	lex.yy.c
		gcc lex.yy.c -lfl

lex.yy.c:			
		flex ass3_17CS30011.l ass3_17CS30011.c
        
clean:
		rm a.out lex.yy.c

run: 		a.out 
		./a.out < ass3_17CS30011_test.c
