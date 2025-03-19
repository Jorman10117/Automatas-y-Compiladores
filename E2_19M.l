/* ---- Parte 1: Declaraciones ---- */
%{
    #include <stdio.h>
    #include "y.tab.h"
%}

IZQ [a-zA-Z0-9._%+-]+
DER [a-zA-Z0-9.-]+
ARROBA @
DOMINIO \.([a-zA-Z]{2,})+

/* ---- Parte 2: Tokens (Reglas) ---- */
%%
{IZQ}+{ARROBA}{DER}+{DOMINIO} { return EMAIL; }

[ \t\f\v\n] { /* Ignorar espacios en blanco y nuevas líneas */ }
.         { /* Ignorar otros caracteres */ }
%%

/* ---- Parte 3: Código ---- */
int yywrap() {
    return 1;
}