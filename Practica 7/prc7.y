%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
void yyerror(const char *s);
FILE *yyin;  // Declaración de yyin
%}

%token SI ENTONCES OP_COMP ID LLAVE_IZQ LLAVE_DER PUNTO_Y_COMA PARENTESIS_IZQ PARENTESIS_DER

%%

programa:
    sentencia
    ;

sentencia:
    SI condicion ENTONCES bloque { printf("Estructura válida.\n"); }
    ;

condicion:
    PARENTESIS_IZQ expresion PARENTESIS_DER
    | ID OP_COMP ID
    ;

expresion:
    ID OP_COMP ID
    ;

bloque:
    LLAVE_IZQ instrucciones LLAVE_DER
    ;

instrucciones:
    instrucciones instruccion
    | instruccion
    ;

instruccion:
    ID PUNTO_Y_COMA
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: la sintaxis es incorrecta\n");
}

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Uso: %s <archivo.txt>\n", argv[0]);
        return 1;
    }
    
    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        printf("No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }
    
    yyin = archivo;  // Asignar el archivo a yyin
    yyparse();
    fclose(archivo);
    return 0;
}
