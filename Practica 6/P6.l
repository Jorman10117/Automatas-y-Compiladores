%{
    #include "y.tab.h"
    #include <stdio.h>
%}

/* Definiciones de patrones */
DIGITO    [0-9]
LETRA     [a-zA-Z_]
ID        {LETRA}({LETRA}|{DIGITO})*
NUM_INT   {DIGITO}+
NUM_DEC   {DIGITO}+\.{DIGITO}+
OP_ARIT   [\+\-\*/]
OP_COMP   (==|!=|<=|>=|<|>)
PAREN     [()]
ESPACIOS  [ \t]+
NUEVA_LINEA  \n
%%
{NUM_INT}   { return NUM_INT; }
{NUM_DEC}   { return NUM_DEC; }
{ID}        { return ID; }
{OP_ARIT}   { return OP_ARIT; }
{OP_COMP}   { return OP_COMP; }
{PAREN}     { return yytext[0]; }
{ESPACIOS}  ; /* Ignorar espacios en blanco */
{NUEVA_LINEA} { return '\n'; }
.           { printf("Carácter no reconocido: %s\n", yytext); }

%%
int yywrap() { return 1; }