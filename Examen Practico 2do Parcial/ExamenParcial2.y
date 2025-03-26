%{
#include<stdio.h>
#include "y.tab.h"
#include <stdio.h>

extern FILE *yyin;

int cont_sim = 0;
int cont_mult = 0;
int yylex(void);
int yywrap();
int yyerror(char* s);
%}

%start program
%union { int inum; }

%token COMENTARIO_SIMPLE
%token COMENTARIO_MULTILINEA

%%

program:
    program exp
    | exp
    ;

exp:
    COMENTARIO_SIMPLE {
        printf("Comentario de 1 línea\n");
        cont_sim++;
    }
    ;

exp:
    COMENTARIO_MULTILINEA {
        printf("Comentario de múltiples líneas\n");
        cont_mult++;
    }
    ;

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <archivo.txt>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");


    yyin = file;

    printf("Inicio\n\n");
    int res = yyparse(); 
    printf("Comentarios simples: %d\n", cont_sim);
    printf("Comentarios multilínea: %d\n\n", cont_mult);
    printf("Terminado, resultado: %d\n", res);

    fclose(file); 
    return res;
}
