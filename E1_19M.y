%{
#include<stdio.h>
int yylex(void);
int yywrap();
int yyerror(char* s);
extern FILE *yyin;
%}

%start program
%union { int inum; }

%token NUMERO
%token OPERADOR

%%

program:
    program expression
    | expression
    ;

expression:
    NUMERO OPERADOR NUMERO {
        printf("Expresion Valida\n");
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
        perror("Error al abrir el archivo");
        return 1;
    }

    yyin = file;

    printf("Inicio\n\n");
    int res = yyparse();
    printf("Terminado, resultado: %d\n", res);

    fclose(file); // Cerrar el archivo
    return res;
}