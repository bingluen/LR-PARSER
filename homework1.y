%{
#include <stdio.h>
%}

%token BASIC WRITE TRUE FALSE BLEFT BRIGHT SLEFT SRIGHT
	AND OR NOT EQUAL NOTEQUAL LESS LESSEQUAL GREATER GREATEREQUAL
	ADD SUB MULT DIV ASSIGN SEMICOLON WHITESPACE

/* create variables */
%union {
	char* string;
}

/* define type of variables */
%token <string> INTEGER
%token <string> ID


%%

Prog:	block
	;

block:	BLEFT decls stmts BRIGHT
	;

decls:	decls decl
	|
	;

decl:	BASIC ID
	;

stmts:	stmts stmt
	|
	;

stmt:	ID ASSIGN bool
	|	WRITE ID
	;

bool:	bool OR join
	|	join
	;

join:	join AND equality
	;

equality:equality EQUAL rel
	|	equality NOTEQUAL rel
	|	rel
	;

rel:	expr LESS expr
	|	expr LESSEQUAL expr
	|	expr GREATER expr
	|	expr GREATEREQUAL expr
	|	expr
	;

expr:	expr ADD term
	|	expr SUB term
	|	term
	;

term:	term MULT unary
	|	term DIV unary
	|	unary
	;

unary:	NOT unary
	|	SUB unary
	|	factor
	;

factor:	SLEFT bool SRIGHT
	|	ID	{ printf("ID"); }
	|	INTEGER { printf("INTEGER"); }
	|	TRUE{ printf("TRUE"); }
	|	FALSE{ printf("FALSE"); }
	;

%%

void main() {
		yyparse();
}
