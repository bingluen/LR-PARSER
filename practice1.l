%{
#include "y.tab.h"
int numLine = 1;
%}

/* Regular Expression */
letter [a-zA-Z]
digit [0-9]

id {letter}({letter}|{digit})*

%%

{id} { yylval.String = strdup(yytext); return ID; }
{digit}+ { yylval.Integer = atoi(yytext); return NUM; }
[\n] { numLine++; }
[<] { return LESS; }
[>] { return GREATER; }
[>][=] { return GREATEREQUAL; }
[<][=] { return LESSEQUAL;}
[=][=] { return EQUAL; }
[!][=] { return NOTEQUAL; }
[=] { return ASSIGN; }
[-] { return SUB; }
[+] { return ADD; }
[!] { return NOT; }

%%

void yyerror (char *s) {
    fprintf (stderr, "%s\n", s);
}

int yywrap() {
	return 1;
}
