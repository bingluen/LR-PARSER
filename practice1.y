%{
#include <stdio.h>
%}

%union{
	char* String;
	int Integer;
}

%token LESS LESSEQUAL GREATER GREATEREQUAL ADD SUB MULT DIV NOT NOTEQUAL ASSIGN EQUAL

%token <String> ID
%token <Integer> NUM

%%

Prog:	Equality
	|
	;

Equality:Equality EQUAL Rel { printf("Equal"); }
	|	Equality NOTEQUAL Rel { printf("NotEqual"); }
	|	Rel
	;

Rel:	Expr LESS Expr { printf("LessThan"); }
	|	Expr LESSEQUAL Expr { printf("LessEq"); }
	|	Expr GREATER Expr { printf("GreaterThan"); }
	|	Expr GREATEREQUAL Expr { printf("GreaterEq"); }
	|	Expr
	;

Expr:	Expr ADD Term { printf("Add"); }
	|	Expr SUB Term { printf("Sub"); }
	|	Term
	;

Term:	Term MULT Unary { printf("Mult"); }
	|	Term DIV Unary { printf("Div"); }
	|	Unary
	;

Unary:	NOT Unary { printf("Not"); }
	|	SUB Unary { printf("Negate"); }
	|	Factor
	;

Factor:	ID	{ /* printf("%s", $1); */ }
	|	NUM	{ /* printf("%d", $1); */ }
	;

%%

main(){
	yyparse();
}
