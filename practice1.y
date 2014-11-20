%{
#include <stdio.h>
%}

%union{
	char* String;
	int Integer;
}

%token LESS LESSEQUAL GREATER GREATEREQUAL ADD SUB MULT DIV NOT NOTEQUAL ASSIGN EQUAL AND OR SEM WRITE BASIC BLEFT BRIGHT TRUE FALSE

%token <String> ID
%token <Integer> NUM

%%

Prog:	Block
	|
	;

Block:	BLEFT Decls Stmts BRIGHT
	;

Decls:	Decls Decl
	|
	;

Decl:	BASIC ID SEM { printf("DCL %s;\n", $2); }

Stmts:	Stmts Stmt
	|
	;

Stmt:	ID { printf("LValue %s;\n", $1); }
	ASSIGN bool SEM { printf("Assign\n"); }
	|	WRITE ID SEM { printf("Output %s\n", $2); }
	;

bool:	bool OR join { printf("Or\n"); }
	|	join
	;

join:	join AND Equality { printf("And\n"); }
	|	Equality
	;

Equality:Equality EQUAL Rel { printf("Equal\n"); }
	|	Equality NOTEQUAL Rel { printf("NotEqual\n"); }
	|	Rel
	;

Rel:	Expr LESS Expr { printf("LessThan\n"); }
	|	Expr LESSEQUAL Expr { printf("LessEq\n"); }
	|	Expr GREATER Expr { printf("GreaterThan\n"); }
	|	Expr GREATEREQUAL Expr { printf("GreaterEq\n"); }
	|	Expr
	;

Expr:	Expr ADD Term { printf("Add\n"); }
	|	Expr SUB Term { printf("Sub\n"); }
	|	Term
	;

Term:	Term MULT Unary { printf("Mult\n"); }
	|	Term DIV Unary { printf("Div\n"); }
	|	Unary
	;

Unary:	NOT Unary { printf("Not\n"); }
	|	SUB Unary { printf("Negate\n"); }
	|	Factor
	;

Factor:	ID	{ printf("RValue %s\n", $1);  }
	|	NUM	{ printf("Push %d\n", $1); }
	|	TRUE	{ printf("Push true\n"); }
	|	FALSE	{ printf("Push false\n"); }
	;

%%

main(){
	yyparse();
}
