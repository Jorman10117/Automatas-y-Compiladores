%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
%}

%token PROTOCOLO SUBDOMINIO DOMINIO BARRA DOSPUNTOS SEGMENTO

%%

url: PROTOCOLO DOSPUNTOS BARRA BARRA subdominio dominio ruta
    {
        printf("¡URL válida!\n");
    }
    ;

subdominio: SUBDOMINIO
    ;

dominio: DOMINIO
    ;

ruta: BARRA SEGMENTO ruta
    | 
    ;

%%

int main(int argc, char **argv) {
    printf("Ingrese una URL para validar:\n");
    yyparse();
    system("pause");
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: La URL no es válida. Revise la estructura.\n");
}