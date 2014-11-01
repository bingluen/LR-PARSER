/* include header file  */
%{

#include "y.tab.h"

int factorF();

#define LOOKUP = 0;

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

[\n\t ] { state = LOOKUP; }


{true} { state = TRUE; }
{false} { state = FALSE; }
{id} { state = ID; }
{num} { state = NUM; }


[a-zA-Z0-9]+ { factorF(); }

%%:

void main()
{
	//printf("type number table:\nID=%d, NUM=%d, FALSE=%d, TRUE=%d\n", ID, NUM, BFALSE, BTRUE);
	yylex();
}


int factorF()
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
