%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

extern FILE *yyin;

int yylex(void);
int yywrap(void);
int yyerror(char* s);
%}

%start program
%union { 
    int inum; 
}

%token IF
%token ELSE
%token THEN
%token CODIGO

%%

program:
    exp
    ;

exp:
    IF CODIGO THEN CODIGO {
        printf("Estructura IF-THEN\n");
    }
    | IF CODIGO THEN CODIGO ELSE CODIGO {
        printf("Estructura IF-THEN-ELSE\n");
    }
    ;

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <archivo.txt>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("No se pudo abrir el archivo");
        return 1;
    }

    yyin = file;

    printf("Inicio\n\n");
    int res = yyparse(); 
    printf("Terminado, resultado: %d\n", res);

    fclose(file); 
    return res;
}


