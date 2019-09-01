#include <stdio.h>
#include "lex.yy.c"


int main()
{
	int a = yyparse();

	if(a==0)
		printf("Parsing Completed successfully\n");
	else
		printf("[ERROR]: Parsing failed\n");
    
    return 0;
}