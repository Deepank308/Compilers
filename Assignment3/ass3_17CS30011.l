/*
Name:- Deepank Agrawal
Roll No:- 17CS30011
Assignment 3 Compilers Lab
*/

/* C Expressions and Declarations */
%{
		#define ESCAPE_SEQUENCE 1
		#define COMMENT 2
		#define ENU_CONSTANT 3
		#define INT_CONSTANT 4
		#define STRING_CON 5
		#define PUNCTUATOR 6
		#define FLOAT_CONSTANT 7
		#define CHAR_CONSTANT 8
		#define IDENTIFIER 9
		#define KEYWORD 10
%}

/* Regular Expression Definitions */

s_char 						[^"\\\n]|{ESCAPE_SEQUENCE}
ENUMERATION_CONSTANT 		{IDENTIFIER}
KEYWORD "auto"|"enum"|"restrict"|"unsigned"|"break"|"extern"|"return"|"void"|"case"|"float"|"short"|"volatile"|"char"|"for"|"signed"|"while"|"const"|"goto"|"sizeof"|"_Bool"|"continue"|"if"|"static"|"_Complex"|"default"|"inline"|"struct"|"_Imaginary"|"do"|"int"|"switch"|"double"|"long"|"typedef"|"else"|"register"|"union"
backother  					[ \t\v\n\f]
c_char 						[^'\\\n]|{ESCAPE_SEQUENCE}
DIGIT						[0-9]
NON_ZERO_DIGIT				[1-9]
ALPHABET 			 		[a-zA-Z_]
INTEGER_CONSTANT 			{NON_ZERO_DIGIT}{DIGIT}*|0
string_constant 			\"({s_char}+)\"
IDENTIFIER 					{ALPHABET}({ALPHABET}|{DIGIT})*
FRACTIONAL_PART 			(({DIGIT}+)?\.{DIGIT}+)|(({DIGIT}+)\.)
SIGNS						[+-]
FLOATING_CONSTANT 			({FRACTIONAL_PART}{EXPONENT_PART}?)|({DIGIT}+{EXPONENT_PART})
EXPONENT_PART				([Ee][+-]?{DIGIT}+)
PUNCTUATOR					"["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
character_constant 			'({c_char})+'
ESCAPE_SEQUENCE				\\['"?\\abfnrtv]

%%

"/*"						{ comment(); return COMMENT;}
"//".*  	   				{ return COMMENT;}
{ESCAPE_SEQUENCE} 			{ return ESCAPE_SEQUENCE;}
{PUNCTUATOR}				{ return PUNCTUATOR;}
{KEYWORD}					{ return KEYWORD;}
{string_constant} 			{ return STRING_CON; }
{IDENTIFIER}				{ return IDENTIFIER; }
{INTEGER_CONSTANT} 			{ return INT_CONSTANT; }
{FLOATING_CONSTANT} 		{ return FLOAT_CONSTANT; }
{ENUMERATION_CONSTANT} 		{ return ENU_CONSTANT; }
{character_constant} 		{ return CHAR_CONSTANT; }
{backother}					{ /* whitespace separates tokens */ }
%%

void comment(void) {
	char c, prev = 0;
	while ((c = input()) != 0) {     /* (EOF maps to 0) */
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	error("[ERROR]:INVALID COMMENTING SYNTAX");
}