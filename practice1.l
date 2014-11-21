%{
#include "y.tab.h"
int numLine = 1;
%}

/* Regular Expression */
letter [a-zA-Z]
digit [0-9]
write [w][r][i][t][e]
basic [b][a][s][i][c]
true [t][r][u][e]
false [f][a][l][s][e]
whitespace [ ]
id {letter}({letter}|{digit})*

%%
{basic} { return BASIC; }
{write} { return WRITE; }
{true} { return TRUE; }
{false} { return FALSE; }
{whitespace}+ {}
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
[&][&] { return AND; }
[|][|] { return OR; }
[-] { return SUB; }
[+] { return ADD; }
[*] { return MULT; }
[/] { return DIV; }
[!] { return NOT; }
[;] { return SEM; }
[{] { return BLEFT; }
[}] { return BRIGHT; }
[(] { return SLEFT; }
[)] { return SRIGHT; }

%%

void yyerror (char *s) {
    fprintf (stderr, "%s\n", s);
}

int yywrap() {
	return 1;
}
