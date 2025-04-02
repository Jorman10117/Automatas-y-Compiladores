%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    void yyerror(const char *s);
    int yylex();
    extern FILE *yyin;
%}

%token NUM_INT NUM_DEC ID OP_ARIT OP_COMP

%%
input:
    input expresion '\n' { printf("Expresión válida.\n"); }
    | input '\n'
    | input error '\n' { printf("Error en la expresión.\n"); yyerrok; }
    | /* vacío */
    ;

expresion:
    termino
    | expresion OP_ARIT termino
    | '(' expresion ')'
    ;

termino:
    NUM_INT | NUM_DEC | ID
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error sintáctico: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <archivo_entrada>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("No se pudo abrir el archivo");
        return 1;
    }

    printf("Procesando archivo: %s\n", argv[1]);
    yyparse();
    fclose(yyin);
    printf("Fin de la entrada", argv[1]);
    return 0;
}
