%{
#include <stdio.h>
#include "y.tab.h"

int state;
%}

/* regular expression */

letter [a-zA-Z]
digit [0-9]

ID {letter}({letter}|{digit})*
NUM {digit}+
FALSE false
TRUE true

%%

{ID} { return ID; }
{NUM} { return NUM; }
{FALSE} { return FALSE; }
{TRUE} { return TRUE;}

%%

