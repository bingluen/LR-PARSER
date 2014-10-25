/* include header file  */
%{
#include <stdio.h>
#include <stdlib.h>
int yywrap();

typedef struct symbolRow symbol;
struct symbolRow
{
	unsigned int symbolIndex;
	char* symbolName;
	unsigned int symbolValue;
	struct symbolRow* next;
};

symbol* symbolTableTop = 0;
unsigned int symbolTableSize = 0;

unsigned int check_ID(char *token);
void add_to_symbol_table(char *token); 

void factorF(char *token);

%}
/* define regular */

digit [0-9]
letter [a-zA-Z]
true [tT][rR][uU][eE]
false [f|F][a|A][l|L][s|S][e|E]
whiteSpace [ \t]

%%

{true} { factorF(yytext); }
{false} { factorF(yytext); }
{id} { factorF(yytext); }
{num} { factorF(yytext); }

%%:

void main()
{
	printf("type number table:\nID=%d, NUM=%d, FALSE=%d, TRUE=%d\n", ID, NUM, BFALSE, BTRUE);
	yylex();
}

int yywrap()
{
	return 1;
}

void add_to_symbol_table(char *token)
{
	//Get symbolName
	char* symbolName = token+5;

	symbol* ptr = (symbol*) malloc(sizeof(symbol));
	ptr->next = symbolTableTop;
	symbolTableTop = ptr;

	ptr->symbolIndex = ++symbolTableSize;
	ptr->symbolName = symbolName;
	ptr->next = 0;
	ptr->symbolValue = 0;

	printf("DCL %s", symbolName);
}

unsigned int check_ID(char *token)
{	
	//for debug
	printf("ID CHECKING");

	symbol* ptr;
	for(ptr = symbolTableTop; ptr->symbolName != token && ptr != 0; ptr = ptr->next)
		
		//for debug
		printf("SymbolData: Index=%d, Name=%s, Value=%d, Next=%p", ptr->symbolIndex, ptr->symbolName, ptr->symbolValue, ptr->next);
	
	if(ptr)
		return ptr->symbolValue;
	else
		return 0;
}


void factorF(char *token)
{
	//for Debug
	//printf("Type is %d\n", tokenType);
	switch(tokenType)
	{
		case NUM:
			printf("Push %s", token);
			break;
		case BTRUE:
			printf("Push true");
			break;
		case BFALSE:
			 printf("Push false");
			 break;
		case ID:
			printf("RValue %d", check_ID(token));
			break;
		default:
			printf("Syntax Error");
	}
	tokenType = lookUP;
}
