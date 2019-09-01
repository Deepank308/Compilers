%{
	#include<stdio.h>
	int yyerror(char *);
	extern int yylex(void);
%}

%token IDENTIFIER
%token CONSTANT
%token STRING_LITERAL
%token UNSIGNED
%token BREAK
%token VOID
%token RETURN
%token CASE
%token FLOAT
%token SHORT
%token CHAR
%token FOR
%token SIGNED
%token WHILE
%token GOTO
%token BOOL
%token CONTINUE
%token IF
%token DEFAULT
%token DO
%token INT
%token SWITCH
%token DOUBLE
%token LONG
%token ELSE
%token MATRIX
%token DASHARROW
%token PLUSPLUS
%token MINMIN
%token DOTQUOTE
%token LSHIFT
%token RSHIFT
%token LTE
%token GTE
%token EQUALS
%token NEQUALS
%token LAND
%token LOR 
%token STAREQ
%token DIVEQ
%token MODEQ
%token PLUSEQ
%token MINEQ
%token LSHIFTEQ
%token RSHIFTEQ
%token ANDEQ
%token POWEQ
%token OREQ
%token ERR
%start translation_unit
%expect 1


%%

/*Expressions*/

primary_expression: IDENTIFIER{printf 	("primary_expression : identifer\n");}
				   |CONSTANT 			{printf("primary_expression : constant\n");}
				   |STRING_LITERAL		{printf("primary_expression : string_literal\n");}
				   |'(' expression ')' 	{printf("primary_expression : (expression)\n");}

postfix_expression: primary_expression 										{printf("postfix_expression : primary_expression\n");}
				   |postfix_expression '[' expression ']'  					{printf("postfix_expression : postfix_expression [expression]\n");}
				   |postfix_expression '(' argument_expression_list_opt ')'	{printf("postfix_expression : postfix_expression (argument_expression_list_opt)\n");}
				   |postfix_expression '.' IDENTIFIER 						{printf("postfix_expression : postfix_expression . IDENTIFER\n");}
				   |postfix_expression DASHARROW IDENTIFIER 				{printf("postfix_expression : postfix_expression -> IDENTIFIER\n");}
				   |postfix_expression PLUSPLUS								{printf("postfix_expression : postfix_expression ++\n");}
				   |postfix_expression MINMIN								{printf("postfix_expression : postfix_expression --\n");}
				   |postfix_expression DOTQUOTE								{printf("postfix_expression : postfix_expression .'\n");}

argument_expression_list_opt: /*empty line*/								{printf("argument_expression_list_opt : epsilon\n");}
							 |argument_expression_list 						{printf("argument_expression_list_opt : argument_expression_list\n");}

argument_expression_list: assignment_expression 							{printf("argument_expression_list : assignment_expression\n");}
						 |argument_expression_list ',' assignment_expression{printf("argument_expression_list : argument_expression_list, assignment_expression\n");}

unary_expression: postfix_expression										{printf("unary_expression : postfix_expression \n");}
		   		 |PLUSPLUS unary_expression									{printf("unary_expression : ++ unary_expression \n");}
		   		 |MINMIN unary_expression 									{printf("unary_expression : -- unary_expression\n");}					
		   		 |unary_operator cast_expression 							{printf("unary_expression : unary_operator cast_expression\n");}	

unary_operator: '&' 														{printf("unary_operator : &\n");}	
			   |'*'															{printf("unary_operator : *\n");}
			   |'+'															{printf("unary_operator : +\n");}
			   |'-'															{printf("unary_operator : -\n");}

cast_expression: unary_expression 											{printf("cast_expression : unary_expression\n");}

multiplicative_expression: cast_expression 									{printf("multiplicative_expression : cast_expression \n");}
						  |multiplicative_expression '*' cast_expression 	{printf("multiplicative_expression : multiplicative_expression * cast_expression\n");}
						  |multiplicative_expression '/' cast_expression 	{printf("multiplicative_expression : multiplicative_expression / cast_expression\n");}
						  |multiplicative_expression '%' cast_expression 	{printf("multiplicative_expression : multiplicative_expression %% cast_expression\n");}


additive_expression: multiplicative_expression  							{printf("additive_expression : multiplicative_expression\n");}
					|additive_expression '+' multiplicative_expression		{printf("additive_expression : additive_expression + multiplicative_expression\n");}
					|additive_expression '-' multiplicative_expression		{printf("additive_expression : additive_expression - multiplicative_expression\n");}

shift_expression: additive_expression										{printf("shift_expression : additive_expression\n");}
				 |shift_expression LSHIFT additive_expression				{printf("shift_expression : shift_expression << additive_expression\n");}
				 |shift_expression RSHIFT additive_expression				{printf("shift_expression : shift_expression >> additive_expression\n");}

relational_expression: shift_expression 									{printf("relational_expression : shift_expression\n");}
					  |relational_expression '<' shift_expression			{printf("relational_expression : relational_expression < shift_expression\n");}
					  |relational_expression '>' shift_expression			{printf("relational_expression : relational_expression > shift_expression\n");}
					  |relational_expression LTE shift_expression			{printf("relational_expression : relational_expression <= shift_expression\n");}
					  |relational_expression GTE shift_expression			{printf("relational_expression : relational_expression >= shift_expression\n");}

equality_expression: relational_expression  								{printf("equality_expression : relational_expression\n");}
				   |equality_expression EQUALS relational_expression 		{printf("equality_expression : equality_expression == relational_expression\n");}
				   |equality_expression NEQUALS relational_expression   	{printf("equality_expression : equality_expression != relational_expression\n");}

AND_expression: equality_expression 										{printf("AND_expression : equality_expression\n");}
			   |AND_expression '&' equality_expression  					{printf("AND_expression : AND_expression & equality_expression\n");}

exclusive_OR_expression: AND_expression 									{printf("exclusive_OR_expression : AND_expression\n");}
				        |exclusive_OR_expression '^' AND_expression  		{printf("exclusive_OR_expression : exclusive_OR_expression ^ AND_expression\n");}

inclusive_OR_expression: exclusive_OR_expression							{printf("inclusive_OR_expression : exclusive_OR_expression\n");}
						|inclusive_OR_expression '|' exclusive_OR_expression{printf("inclusive_OR_expression : inclusive_OR_expression | exclusive_OR_expression\n");}

logical_AND_expression: inclusive_OR_expression								{printf("logical_AND_expression : inclusive_OR_expression\n");}
					   |logical_AND_expression LAND inclusive_OR_expression	{printf("logical_AND_expression : logical_AND_expression && inclusive_OR_expression\n");}

logical_OR_expression: logical_AND_expression 								{printf("logical_OR_expression : logical_AND_expression\n");}
					  |logical_OR_expression LOR logical_AND_expression 	{printf("logical_OR_expression : logical_OR_expression || logical_AND_expression\n");}

conditional_expression: logical_OR_expression 											{printf("conditional_expression : logical_OR_expression\n");}
					   |logical_OR_expression '?' expression ':' conditional_expression	{printf("conditional_expression : logical_OR_expression ? expression : conditional_expression\n");}

assignment_expression: conditional_expression										{printf("assignment_expression : conditional_expression\n");}
			          |unary_expression assignment_operator assignment_expression 	{printf("assignment_expression : unary_expression assignment_operator assignment_expression\n");}

assignment_operator: '='													{printf("assignment_operator : =\n");}
					|STAREQ													{printf("assignment_operator : *=\n");}
					|DIVEQ													{printf("assignment_operator : /=\n");}
					|MODEQ													{printf("assignment_operator : %%=\n");}		
					|PLUSEQ													{printf("assignment_operator : +=\n");}
					|MINEQ													{printf("assignment_operator : -=\n");}
					|LSHIFTEQ												{printf("assignment_operator : <<=\n");}
					|RSHIFTEQ												{printf("assignment_operator : >>=\n");}
					|ANDEQ													{printf("assignment_operator : &=\n");}
					|POWEQ													{printf("assignment_operator : ^=\n");}	
					|OREQ													{printf("assignment_operator : |=\n");}

expression: assignment_expression 											{printf("expression : assignment_expression\n");}									            |expression ',' assignment_expression 							{printf("assignment_operator : expression , assignment_expression\n");}

constant_expression: conditional_expression 								{printf("constant_expression : conditional_expression\n");}

/*Declarations*/

declaration: declaration_specifiers init_declarator_list_opt ';'			{printf("declaration : declaration_specifiers init_declarator_list_opt\n");}

declaration_specifiers: type_specifier										{printf("declaration_specifiers : type_specifier\n");}
						|type_specifier declaration_specifiers 				{printf("declaration_specifiers : type_specifier declaration_specifiers\n");}

init_declarator_list_opt: /*empty line*/ 									{printf("init_declarator_list_opt : epsilon\n");}
					    |init_declarator_list 								{printf("init_declarator_list_opt : init_declarator_list\n");}

init_declarator_list: init_declarator 										{printf("init_declarator_list : init_declarator\n");}
					 |init_declarator_list ',' init_declarator 				{printf("init_declarator_list : init_declarator_list, init_declarator\n");}			

init_declarator: declarator 												{printf("init_declarator : declarator\n");}
				|declarator '=' initializer 								{printf("init_declarator : declarator = initializer\n");}	

type_specifier: VOID 														{printf("type_specifier : void\n");}		
				|CHAR 														{printf("type_specifier : char\n");}	
				|SHORT 														{printf("type_specifier : short\n");}	
				|INT 														{printf("type_specifier : int\n");}
				|LONG 														{printf("type_specifier : long\n");}	
				|FLOAT 														{printf("type_specifier : float\n");}
				|DOUBLE 													{printf("type_specifier : double\n");}	
				|MATRIX 													{printf("type_specifier : matrix\n");}	
				|SIGNED 													{printf("type_specifier : signed\n");}
				|UNSIGNED 													{printf("type_specifier : unsigned\n");}
				|BOOL 														{printf("type_specifier : bool\n");}

declarator: pointer_opt direct_declarator 									{printf("declarator : pointer_opt direct_declarator\n");}

pointer_opt : /*empty line*/ 												{printf("pointer_opt : epsilon\n");}
			 |pointer 														{printf("pointer_opt : pointer\n");}

direct_declarator: IDENTIFIER  												{printf("direct_declarator : IDENTIFIER\n");}	
				  |'(' declarator ')' 										{printf("direct_declarator : ( declarator )\n");}
				  |direct_declarator '[' assignment_expression_opt ']' 		{printf("direct_declarator : direct_declarator [ assignment_expression_opt ]\n");}	
				  |direct_declarator '(' parameter_type_list ')' 			{printf("direct_declarator : direct_declarator ( parameter_type_list )\n");}
				  |direct_declarator '(' identifier_list_opt ')'			{printf("direct_declarator : direct_declarator ( identifier_list_opt )\n");}
 
assignment_expression_opt: /*empty line*/ 									{printf("assignent_expression_opt : epsilon\n");}
						 |assignment_expression 							{printf("assignent_expression_opt : assignment_expression\n");}

identifier_list_opt: /*empty line*/ 										{printf("identifier_list_opt : epsilon\n");}		
					 |identifier_list 										{printf("identifier_list_opt : identifier_list\n");}	

pointer: '*' pointer_opt 													{printf("pointer :  * pointer_opt\n");}		

parameter_type_list: parameter_list 										{printf("parameter_type_list : parameter_list\n");}

parameter_list: parameter_declaration 										{printf("parameter_list : parameter_declaration\n");}
		 	   |parameter_list ',' parameter_declaration 					{printf("parameter_list : parameter_list , parameter_declaration\n");}	

parameter_declaration: declaration_specifiers declarator 					{printf("parameter_declaration : declaration_specifiers declarator\n");}
					  |declaration_specifiers 								{printf("parameter_declaration : declaration_specifiers\n");}	

identifier_list: IDENTIFIER  												{printf("identifier_list : IDENTIFIER\n");}	
				|identifier_list ',' IDENTIFIER 							{printf("identifier_list : identifier_list , IDENTIFIER\n");}

initializer: assignment_expression 											{printf("initializer : assignment_expression\n");}	
			|'{' initializer_row_list '}' 									{printf("initializer : { initializer_row_list }\n");}

initializer_row_list: initializer_row 										{printf("initializer_row_list : initializer_row\n");}	
					 |initializer_row_list ';' initializer_row 				{printf("initializer_row_list : initializer_row_list , initializer_row\n");}

initializer_row: designation_opt initializer 								{printf("initializer_row : designation_opt initializer\n");} 
				|initializer_row ',' designation_opt initializer 			{printf("initializer_row : initializer_row , designation_opt initializer\n");}			
 
designation_opt: /*empty line*/												{printf("designation_opt : epsilon\n");}
				|designation  												{printf("designation_opt : designation\n");}	

designation: designator_list '=' 											{printf("designation : designation_list =\n");}

designator_list: designator 												{printf("designator_list : designator\n");}
				 |designator_list designator  								{printf("designator_list : designator_list designator\n");}

designator: '[' constant_expression ']' 									{printf("designator : [ constant_expression ] \n");}
		   |'.' IDENTIFIER 													{printf("designator : . INDENTIFIER \n");}	

/*Statements*/

statement: labeled_statement											 	{printf("statement : labeled_statement \n");}			
		  |compound_statement												{printf("statement : compound_statement \n");}
		  |expression_statement												{printf("statement : expression_statement\n");}	
		  |selection_statement												{printf("statement : selection_statement\n");}
		  |iteration_statement												{printf("statement : iteration_statement\n");}
		  |jump_statement													{printf("statement : jump_statement\n");}	

labeled_statement: IDENTIFIER ':' statement 								{printf("labeled_statement : IDENTIFIER : statement\n");}
				  |CASE constant_expression ':' statement 					{printf("labeled_statement : CASE constant_expression : statement\n");}
				  |DEFAULT ':' statement 									{printf("labeled_statement : DEFAULT : statement\n");}

compound_statement: '{' block_item_list_opt '}'								{printf("compound_statement : { block_item_list_opt }\n");}

block_item_list_opt : /*empty line*/										{printf("block_item_list_opt : epsilon\n");}
					 |block_item_list 										{printf("block_item_list_opt : block_item_list\n");}

block_item_list: block_item 												{printf("block_item_list : block_item\n");}
				|block_item_list block_item 								{printf("block_item_list : block_item_list block_item\n");}

block_item: declaration  													{printf("block_item : declaration\n");}
		   |statement 														{printf("block_item : statement\n");}		

expression_statement: expression_opt ';'									{printf("expression_statement : expression_opt ;\n");}		

selection_statement: IF'(' expression ')' statement 						{printf("selection_statement : if( expression ) statement\n");}		
					|IF'(' expression ')' statement ELSE statement 			{printf("selection_statement : if( expression ) statement else statement\n");}				
					|SWITCH '(' expression ')' statement 					{printf("selection_statement : switch( expression ) statement\n");}

iteration_statement: WHILE '(' expression ')' statement 											{printf("iteration_statement : while ( expression ) statement\n");}	
					|DO statement WHILE '(' expression ')' ';'										{printf("iteration_statement : do statement while ( expression ) ;\n");}
					|FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement 	{printf("iteration_statement : for (expression_opt ; expression_opt ; expression_opt ) statement\n");}
					|FOR '(' declaration expression_opt ':' expression_opt ')' statement  			{printf("iteration_statement : for(declaration expression_opt : expression_opt ) statement\n");}

jump_statement: GOTO IDENTIFIER';' 											{printf("jump_statement : goto identifier;\n");}
				|CONTINUE';' 												{printf("jump_statement : continue;\n");}
				|BREAK';'													{printf("jump_statement : break;\n");}	
				|RETURN expression_opt ';' 									{printf("jump_statement : return expression_opt\n");}

expression_opt: /*empty line*/												{printf("expression_opt : epsilon\n");}
			   |expression 													{printf("expression_opt : expression\n");}		

/* External Definitions */

translation_unit: external_declaration										{printf("translation_unit : external_declaration\n");}
				 |translation_unit external_declaration						{printf("translation_unit : translation_unit external_declaration\n");}

external_declaration: function_definition									{printf("external_declaration : function_definition\n");}
					 |declaration 											{printf("external_declaration : declaration\n");}

function_definition: declaration_specifiers declarator declaration_list_opt compound_statement  	{printf("function_definition : declaration_specifiers declarator declaration_list_opt compound_statement\n");}

declaration_list_opt: /*empty line*/										{printf("declaration_list_opt : epsilon\n");}
					 |declaration_list 										{printf("declaration_list_opt : declaration_list\n");}

declaration_list : declaration 												{printf("declaration_list : declaration\n");}
				  |declaration_list declaration 							{printf("declaration_list : declaration_list\n");}

%%

int yyerror(char *err){
  printf("[ERROR]: %s while parsing token : %s \n", err, yytext);
  return -1;
}