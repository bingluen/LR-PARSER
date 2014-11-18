%{
#include <stdio.h>
%}

%token ID NUM

%%

rel:	expr'<'expr
	|	expr'<''='expr
	|	expr'>'expr
	|	expr'>''='expr
	|	expr
	;

expr:	expr'+'term
	|	expr'-'term
	|	term
	;

term:	term'*'unary
	|	term'/'unary
	|	unary
	;

unary:	'!'unary
	|	'-'unary
	|	factor
	;

factor:	ID	{ printf("input is ID"); }
	|	NUM	{ printf("input is NUM"); }
	;

%%

int main() {
	do {
		yyparse();
	}while(1);
	return 0;
}
