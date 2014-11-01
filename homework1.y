%{
#include <stdio.h>

typedef struct symbolRow symbol;
struct symbolRow
{
	unsigned int symbolIndex;
	char* symbolName;
	unsigned int symbolValue;
	struct symbolRow* next;
};

symbol* symbolTableTop = 0;
int symbolTableSize = 0;

int check_ID(char *token);
void add_to_symbol_table(char *token); 

%}

%token ID NUM TRUE FALSE

%%

/* Grammar */
Prog: block 
	;

block: '{' decls stmts '}'
	;

decls: decls decl
	|;

decl: 'b''a''s''i''c'' 'ID';' {add_to_symbol_table(ID); print (“DCL %s”, ID)}
	;

stmts: stmts stmt
	;

stmt: ID{ check_ID(ID); printf (“LValue %s”, ID); }'='bool';'{ printf("Assign"); } 
	|'w''r''i''t''e' ID';'
	;

bool: bool'|''|'join { printf("Or"); }
	|join
	;

join: join'&''&'equality { printf("And"); }
	|equality
	;

equality: equality'=''='rel { printf("Equal"); }
	|equality'!''='rel {printf("NotEqal"); }
	|rel
	;

rel: expr'<'expr { printf("LessThan"); }
	|expr'<''='expr { printf("LessEq"); }
	|expr'>'expr { printf("GreaterThan"); }
	|expr'>''='expr { printf("GreaterEq"); }
	|expr
	;

expr: expr'+'term { printf("Add"); }
	|expr'-'term { printf("Sub"): }
	|term
	;

term: term'*'unary { printf("Mult"); }
	|term'/'unary { printf("Div"); }
	|unary
	;

unary: '!'unary { printf("Not"); }
	|'-'unary { printf("Negate"); }
	|factor
	;

factor: '('bool')'
	|ID { check_ID(ID); printf("RValue %s", ID); }
	|NUM { printf("Push %s", NUM); }
	|TRUE { printf("Push true"); }
	|FALSE { printf("Push false"); }
	;

%%

extern FILE *yyin

void main() {
	do {
		yyparse();
	} while(!feof(yyin));
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


int check_ID(char *token)
{
	//for debug
	printf("ID CHECKING");
	symbol* ptr;
	for(ptr = symbolTableTop; ptr->symbolName != token && ptr != 0; ptr = ptr->next)
	//for debug
	//printf("SymbolData: Index=%d, Name=%s, Value=%d, Next=%p", ptr->symbolIndex, ptr->symbolName, ptr->symbolValue, ptr->next);
	if(ptr)
		return ptr->symbolValue;
	else
		return 0;
}
