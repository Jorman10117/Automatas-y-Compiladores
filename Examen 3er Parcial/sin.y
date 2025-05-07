%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

%token NUM MULT SUMA IPAREN CPAREN LINEA EXIT

%%

input: 
    | input line
    ;

line:
      expr LINEA   { printf("Expresion valida\n"); }
    | EXIT LINEA   { printf("Cerrando programa\n"); exit(0); }
    ;

expr:
      expr MULT expr   { }  
    | expr SUMA expr   { }  
    | NUM              { }  
    | IPAREN expr CPAREN { } 
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error de sintaxis\n");
}

int main() {
    printf("Ingrese las operaciones, presione e para salir\n\n");
    while(1) {
        
        yyparse();
    }
    return 0;
}