%{
#include <stdio.h>
#include<stdlib.h>
#include<string.h>
#include"y.tab.h"
int numline = 1;
%}

/* regular expression */

letter [a-zA-Z]
digit [0-9]

id {letter}({letter}|{digit})*
num {digit}+
false [f][a][l][s][e]
true [t][r][u][e]

whitespace [ ]

%%

[ \t] {}
"\n" { numline++; }
"basic" { return BASIC; }
"write" { return WRITE; }
"true" { return TRUE; }
"false" { return FALSE; }
"{" { return BLEFT; }
"}" { return BRIGHT; }
"(" { return SLEFT; }
")" { return SRIGHT; }
"&&" { return AND; }
"||" { return OR; }
"!" { return NOT; }
"==" { return EQUAL; }
"!=" { return NOTEQUAL; }
"<" { return LESS; }
"<=" { return LESSEQUAL; }
">" { return GREATER; }
">=" { return GREATEREQUAL; }
"+" { return ADD; }
"-" { return SUB; }
"*" { return MULT; }
"/" { return DIV; }
"=" { return ASSIGN; }
";" { return SEMICOLON; }
id { yylval.string = strdup(yytext); return ID; }
num { yylval.string = strdup(yytext); return INTEGER; }
whitespace { return WHITESPACE; }

%%

yywrap() {
	return 1;
}

void yyerror (char *s) {
    fprintf (stderr, "%s\n", s);
}

