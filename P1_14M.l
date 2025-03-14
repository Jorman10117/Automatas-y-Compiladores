/* ---- Parte 1: Declaraciones ---- */
%{
    #include <stdio.h>
    #include "y.tab.h"

    extern YYSTYPE yylval;

    int yywrap();
    int yyerror(char* s);
%}

/* ---- Parte 2: Tokens (Reglas) ---- */
%%
[0-9]+  { return NUMERO; }
[+/*-]   { return OPERADOR; }

[ \t\f\v] { /* Ignorar espacios en blanco */ }

.         { return *yytext; }

%%

/* ---- Parte 3: Código ---- */
int yywrap() {
    return 1;
}

int yyerror(char* s) {
    fprintf(stderr, "%s\n", s);
    return 1;
}
