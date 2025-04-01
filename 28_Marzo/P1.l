%option noyywrap
%{
#include <stdio.h>
#include "y.tab.h"

int yyerror(char* s);
%}

%%

"if"            { return IF; }
"then"          { return THEN; }
"else"          { return ELSE; }
[a-zA-Z_][a-zA-Z0-9_]*  { return CODIGO; }
[ \t\n]+          { /* Ignorar espacios en blanco y saltos de línea */ }
.                 { /* Ignorar otros caracteres no definidos */ }

%%

int yyerror(char* s) {
    fprintf(stderr, "Error: %s\n", s); 
    return 1;
}
