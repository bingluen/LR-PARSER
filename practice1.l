%{
#include "y.tab.h"
extern int yylval;

%}

/* Regular Expression */
letter [a-zA-Z]
digit [0-9]

id {letter}({letter}|{digit})*
num {digit}+

%%

{id} { return ID; }
{num} { return NUM; }
[\n\t ]

%%

void yyerror (char *s) {
    fprintf (stderr, "%s\n", s);
}

int yywrap() {
	return 1;
}
