%{
#include <stdio.h>
%}

%token NUM ID FALSE TRUE

%%

Prog:	block
	;

block:	'{'decls stmts'}'
	;

decls:	decls decl
	|
	;

decl:	'b''a''s''i''c'' 'ID';'

stmts:	stmts stmt
	|
	;

stmt:	ID'='bool';'
	|	'w''r''i''t''e'' 'ID';'
	;

bool:	bool'|''|'join
	|	join
	;

join:	join'&''&'equality
	;

equality:equality'=''='rel
	|	equality'!''='rel
	|	rel
	;

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

factor:	'('bool')'
	|	ID	{ printf("ID"); }
	|	NUM { printf("NUM"); }
	|	TRUE{ printf("TRUE"); }
	|	FALSE{ printf("FALSE"); }
	;

%%

void main() {
	do {
		yyparse();
	while(!eof(yyin));
}
