%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* subroutine */
void insertToSymbolTable(char*);
void checkID(char*);

/* symbol table */
struct symbol {
	int idsn;
	char* symbol;
	struct symbol* next;
};

struct symTab{
	int symNum;
	struct symbol* table;
};

/* init symbolTable */

struct symTab symbolTable = {.symNum = 0, .table = 0};

extern numLine;

/* global flag */
int dclFlag = 0;
%}

%union{
	char* String;
	int Integer;
}

%token LESS LESSEQUAL GREATER GREATEREQUAL ADD SUB MULT DIV NOT NOTEQUAL ASSIGN EQUAL AND OR SEM WRITE BASIC BLEFT BRIGHT TRUE FALSE

%token <String> ID
%token <Integer> NUM

%%

Prog:	Block
	|
	;

Block:	BLEFT Decls Stmts BRIGHT
	;

Decls:	Decls Decl
	|
	;

Decl:	BASIC ID SEM { insertToSymbolTable($2);  if(!dclFlag) printf("DCL %s;\n", $2);  dclFlag = 0;}

Stmts:	Stmts Stmt
	|
	;

Stmt:	ID { checkID(yylval.String);  printf("LValue %s;\n", $1); }
	ASSIGN bool SEM { printf("Assign\n"); }
	|	WRITE ID SEM { checkID(yylval.String);  printf("Output %s\n", $2); }
	;

bool:	bool OR join { printf("Or\n"); }
	|	join
	;

join:	join AND Equality { printf("And\n"); }
	|	Equality
	;

Equality:Equality EQUAL Rel { printf("Equal\n"); }
	|	Equality NOTEQUAL Rel { printf("NotEqual\n"); }
	|	Rel
	;

Rel:	Expr LESS Expr { printf("LessThan\n"); }
	|	Expr LESSEQUAL Expr { printf("LessEq\n"); }
	|	Expr GREATER Expr { printf("GreaterThan\n"); }
	|	Expr GREATEREQUAL Expr { printf("GreaterEq\n"); }
	|	Expr
	;

Expr:	Expr ADD Term { printf("Add\n"); }
	|	Expr SUB Term { printf("Sub\n"); }
	|	Term
	;

Term:	Term MULT Unary { printf("Mult\n"); }
	|	Term DIV Unary { printf("Div\n"); }
	|	Unary
	;

Unary:	NOT Unary { printf("Not\n"); }
	|	SUB Unary { printf("Negate\n"); }
	|	Factor
	;

Factor:	ID	{ checkID($1); printf("RValue %s\n", $1);  }
	|	NUM	{ printf("Push %d\n", $1); }
	|	TRUE	{ printf("Push true\n"); }
	|	FALSE	{ printf("Push false\n"); }
	;

%%

main(){
	yyparse();
}

void insertToSymbolTable (char* id)
{
	//check ID
	int flag = 0; // 0 = not declared 1= declared
	int i;
	struct symbol *ptr;
	for(i = 0, ptr = symbolTable.table; 
		i < symbolTable.symNum; 
		i++, ptr = ptr->next)
	{
		if(strlen(id) != strlen(ptr->symbol))
		{
			continue;
		}
		else
		{
			int j;
			for(j = 0; 
				j < strlen(ptr->symbol)
			 	&& ptr->symbol[j] == id[j]; 
				j++);
			if(j == strlen(ptr->symbol))
			{
				flag = 1;
				break;
			}
		}
	}

	if(flag == 1)
	{
		dclFlag = 1;
		printf("**** Error on line %d : Identifier '%s' is re-declared!!.\n\tThe declaraction statement will be ignored.\n", numLine, id);
	}
	else
	{
		if(symbolTable.symNum == 0)
		{
			symbolTable.table = malloc(sizeof(struct symbol));
			symbolTable.table->symbol = id;
			symbolTable.table->idsn = symbolTable.symNum;
			symbolTable.table->next = 0;
		}
		else
		{
			//go to end
			struct symbol* ptr;
			int j;
			for(j = 0, ptr = symbolTable.table; j < symbolTable.symNum - 1; j++, ptr = ptr->next);
			ptr->next = malloc(sizeof(struct symbol));
			ptr = ptr->next;
			ptr->symbol = id;
			ptr->idsn = symbolTable.symNum;
			ptr->next = 0;
		}
		symbolTable.symNum++;
	}
}

void checkID(char* id)
{
	int flag = 0; // 0 = not declared 1= declared
	int i;
	struct symbol *ptr;
	for(i = 0, ptr = symbolTable.table; 
		i < symbolTable.symNum; 
		i++, ptr = ptr->next)
	{
		if(strlen(id) != strlen(ptr->symbol))
		{
			continue;
		}
		else
		{
			int j;
			for(j = 0; 
				j < strlen(ptr->symbol)
			 	&& ptr->symbol[j] == id[j]; 
				j++);
			if(j == strlen(ptr->symbol))
			{
				flag = 1;
				break;
			}
		}
	}
	
	if(flag == 0)
	{
		printf("**** Error on line %d : Identifier '%s' is NOT declared!!.\n", numLine, id);
		printf("**** ABORT\n");
		exit(1);
	}
}
