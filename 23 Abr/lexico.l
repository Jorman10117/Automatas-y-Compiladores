%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "y.tab.h"

int yylex(void);
void yyerror(const char *s);
%}

%%

[ \t]    ;  /* Ignora espacios y tabs */
\n       { return NUEVA; }
[0-9]+(\.[0-9]+)?  { yylval.num = atof(yytext); return NUMERO; }
"+"      { return SUMA; }
"-"      { return RESTA; }
"*"      { return MULTIPLICACION; }
"/"      { return DIVISION; }
"^"      { return POTENCIA; }
"("      { return PARENTESIS_IZQ; }
")"      { return PARENTESIS_DER; }
"sin"    { return SIN; }
"cos"    { return COS; }
"tan"    { return TAN; }
"e"      { return EXIT; }  /* Nueva regla para la letra 'e' */
.        { yyerror("Caracter no reconocido"); return 0; }

%%

int yywrap(void) {
    return 1;
}