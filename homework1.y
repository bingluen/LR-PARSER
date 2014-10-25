%{
#include <stdio.h>
%}

%token ID, NUM, TRUE, FALSE

%%

/* Grammar */
id {letter}({letter}|{digit})*
num {digit}+

Prog {block}

block \{{decls}{stmts}\}

decls {decls}{whiteSpace}{whiteSpace}*{decl}|{whilespace}

decl basic{whiteSpace}{whiteSpace}*{id};

stmts {stmts}{whiteSpace}*{stmt}|{whilespace}

stmt {id}{whiteSpace}*={whiteSpace}{bool};|write{whiteSpace}*{id};

bool {bool}{join}|{join}

join {join}\&\&{equality}

equality {equality}=={rel}|{equality}!={rel}|{rel}

rel {expr}{whiteSpace}*<{whiteSpace}*{expr}|{expr}{whiteSpace}*<={whiteSpace}*{expr}|{expr}{whiteSpace}*>{whiteSpace}*{expr}|{expr}{whiteSpace}*>={whiteSpace}*{expr}|{expr}

expr {expr}\+{term}|{expr}\-{term}|{term}

term {term}\*{unary}|{term}/{unary}|{unary}

unary \!{unary}|\-{unary}|{factor}

factor ({bool})|{id}|{num}|{true}|{false}

