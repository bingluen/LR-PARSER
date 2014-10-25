/* include header file  */
%{

#include "y.tab.h"

void factorF(char *token);

enum {
	LOOKUP = 0,
	NUM,
	ID,
	TRUE,
	FALSE
};

int state;

%}
/* define regular */

digit [0-9]
letter [a-zA-Z]
true [tT][rR][uU][eE]
false [f|F][a|A][l|L][s|S][e|E]

id {letter}({letter}|{digit})*
num {digit}+

%%

\n { state = LOOKUP; }


{true} { state = TRUE; factorF(yytext); }
{false} { state = FALSE; factorF(yytext); }
{id} { state = ID; factorF(yytext); }
{num} { state = NUM; factorF(yytext); }


%%:

void main()
{
	//printf("type number table:\nID=%d, NUM=%d, FALSE=%d, TRUE=%d\n", ID, NUM, BFALSE, BTRUE);
	yylex();
}


void factorF(char *token)
{
	//for Debug

	switch(state)
	{
		case NUM:
			return NUM;
		case TRUE:
			return TRUE;
		case FALSE:
			return FALSE;
		case ID:
			return ID;
		default:
			printf("Syntax Error");
	}
	state = LOOKUP;
}
