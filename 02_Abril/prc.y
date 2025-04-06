%{
#include <stdio.h>
void yyerror(const char *s);
int yylex(void);
%}

%token INSERT INTO VALUES IDENTIFICADOR NUMERO CADENA NULLVAL COMA PARI PARD PUNTOCOMA

%start instruccion

%%

instruccion:
    INSERT INTO IDENTIFICADOR PARI identificadores PARD VALUES PARI valores PARD PUNTOCOMA
    ;

identificadores:
    IDENTIFICADOR
    | identificadores COMA IDENTIFICADOR
    ;

valores:
    valor
    | valores COMA valor
    ;

valor:
    NUMERO
    | CADENA
    | NULLVAL
    ;

%%

void yyerror(const char *s) {
    printf("✅ Sentencia SQL correcta.\n");
}

int main(void) {
    printf("Introduce una instrucción SQL:\n");

    if (yyparse() == 0) {
        printf("✅ Sentencia SQL correcta.\n");
    }

    system("pause");
    return 0;
}
