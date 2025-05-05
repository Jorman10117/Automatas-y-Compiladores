%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylineno = 1;
extern FILE *yyin;
%}

%option noyywrap nounput noinput

digit      [0-9]
letter     [a-zA-Z_]
id         {letter}({letter}|{digit})*
number     {digit}+

%%

"inicio"        { return INICIO; }
"fin"           { return FIN; }
"entero"        { return ENTERO; }
"mostrar"       { return MOSTRAR; }
"si"            { return SI; }
"sino"          { return SINO; }

{id}            { yylval.str = strdup(yytext); return ID; }
{number}        { yylval.ival = atoi(yytext); return NUM; }

"="             { return '='; }
";"             { return ';'; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"("             { return '('; }
")"             { return ')'; }

[ \t]+          ;  /* Ignorar espacios */
\n              { yylineno++; }
.               { fprintf(stderr, "Error léxico en línea %d: Carácter inválido '%s'\n", yylineno, yytext); }

%%