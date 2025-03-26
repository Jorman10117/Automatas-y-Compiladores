%option noyywrap
%{
#include <stdio.h>
#include "y.tab.h"
int yyerror(char* s);
%}

%%

"//".*           { return COMENTARIO_SIMPLE; }  
"/*"[^*]*"*/"    { return COMENTARIO_MULTILINEA; }
.        

%%

int yyerror(char* s) {
    fprintf(stderr, "Error: %s\n", s); 
    return 1;
}
