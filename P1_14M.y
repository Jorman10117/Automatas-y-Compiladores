/* ---- Parte 1: Declaraciones ---- */
%{
    #include <stdio.h>

    int yylex(void);
    int yywrap();
    int yyerror(char* s);
%}

%start program

%union { int inum; }

/* ---- Parte 2: Definición de Tokens ---- */
%token NUMERO 
%token OPERADOR

/* ---- Parte 3: Reglas Gramaticales ---- */
%%
program:
    NUMERO OPERADOR NUMERO{
        printf("Correcto\n");
    }
    ;

%%

/* ---- Parte 4: Programa Principal ---- */
int main() {
    printf("beginning\n");
    int res = yyparse();
    printf("ending, %d\n", res);
    return res;
}
