%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern int yylineno;
int yylex(void);
void yyerror(const char *s);

typedef struct symbol {
    char *name;
    int defined;
    int value;
} symbol;

symbol symtab[100];
int symcount = 0;

int is_defined(char *name) {
    int i;
    for (i = 0; i < symcount; i++)
        if (strcmp(symtab[i].name, name) == 0)
            return 1;
    return 0;
}

symbol* get_symbol(char *name) {
    int i;
    for (i = 0; i < symcount; i++)
        if (strcmp(symtab[i].name, name) == 0)
            return &symtab[i];
    return NULL;
}

void define(char *name) {
    int i;
    for (i = 0; i < symcount; i++) {
        if (strcmp(symtab[i].name, name) == 0) {
            symtab[i].defined = 1;
            return;
        }
    }
    symtab[symcount].name = strdup(name);
    symtab[symcount].defined = 1;
    symtab[symcount].value = 0;
    symcount++;
}
%}

%union {
    int ival;
    char *str;
}

%token <str> ID
%token <ival> NUM
%token INICIO FIN ENTERO MOSTRAR SI SINO

%type <ival> expr

%%

programa:
    INICIO instrucciones FIN { printf("Programa ejecutado correctamente\n"); }
    ;

instrucciones:
    /* vacío */
    | instrucciones instruccion
    ;

instruccion:
    ENTERO ID ';'           { define($2); free($2); }
    | ID '=' expr ';'       {
                                symbol* s = get_symbol($1);
                                if (!s) {
                                    fprintf(stderr, "Error semántico en línea %d: Variable '%s' no definida\n", yylineno, $1);
                                } else {
                                    s->value = $3;
                                }
                                free($1);
                            }
    | MOSTRAR ID ';'        {
                                symbol* s = get_symbol($2);
                                if (!s) {
                                    fprintf(stderr, "Error semántico en línea %d: Variable '%s' no definida\n", yylineno, $2);
                                } else {
                                    printf(">> %s = %d\n", s->name, s->value);
                                }
                                free($2);
                            }
    | MOSTRAR expr ';'      { printf(">> %d\n", $2); }
    ;

expr:
    NUM                     { $$ = $1; }
    | ID                    {
                                symbol* s = get_symbol($1);
                                if (!s) {
                                    fprintf(stderr, "Error semántico en línea %d: Variable '%s' no definida\n", yylineno, $1);
                                    $$ = 0;
                                } else {
                                    $$ = s->value;
                                }
                                free($1);
                            }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         { 
                                if ($3 == 0) {
                                    yyerror("División por cero");
                                    $$ = 0;
                                } else {
                                    $$ = $1 / $3; 
                                }
                            }
    | '(' expr ')'          { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error sintáctico en línea %d: %s\n", yylineno, s);
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s archivo.txt\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        perror("Error al abrir el archivo");
        return 1;
    }
    
    yyin = archivo;
    yylineno = 1;  // Reiniciar contador de líneas
    
    yyparse();
    fclose(archivo);
    
    // Liberar memoria
    int i;
    for (i = 0; i < symcount; i++) {
        free(symtab[i].name);
    }
    
    return 0;
}