%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);

extern FILE *yyin;
int salida = 0;
%}

%union {
    double num;
}

%token <num> NUMERO
%token SUMA RESTA MULTIPLICACION DIVISION POTENCIA
%token PARENTESIS_IZQ PARENTESIS_DER
%token SIN COS TAN NUEVA EXIT

%type <num> expresion termino factor exponente componente trigonometria

%left SUMA RESTA
%left MULTIPLICACION DIVISION
%right POTENCIA
%left UNARY

%%

inicio:
    | inicio linea
    ;

linea:
    expresion NUEVA {        
        printf("Resultado: %g\n\n", $1);
    }
    | EXIT NUEVA { salida = 1; }
    | NUEVA
    ;

expresion:
    expresion SUMA termino {        
        printf("Operacion: Suma\n");
        $$ = $1 + $3;
    }
    | expresion RESTA termino {        
        printf("Operacion: Resta\n");
        $$ = $1 - $3;
    }
    | termino {
        $$ = $1;
    }
    ;

termino:
    termino MULTIPLICACION factor {
        printf("Operacion: Multiplicacion\n");
        $$ = $1 * $3;
    }
    | termino DIVISION factor {        
        printf("Operacion: Division\n");
        $$ = $1 / $3;
    }
    | factor {
        $$ = $1;
    }
    ;

factor:
    exponente {
        $$ = $1;
    }
    | RESTA factor %prec UNARY {        
        printf("Operacion: Negacion\n");
        $$ = -$2;
    }
    ;

exponente:
    componente POTENCIA exponente {        
        printf("Operacion: Potencia\n");
        $$ = pow($1, $3);
    }
    | componente {
        $$ = $1;
    }
    ;

componente:
    NUMERO {
        $$ = $1;
    }
    | PARENTESIS_IZQ expresion PARENTESIS_DER {        
        printf("Operacion: Expresion compuesta\n");
        $$ = $2;
    }
    | trigonometria {
        $$ = $1;
    }
    ;

trigonometria:
    SIN PARENTESIS_IZQ expresion PARENTESIS_DER {        
        printf("Operación: Seno\n");
        $$ = sin($3);
    }
    | COS PARENTESIS_IZQ expresion PARENTESIS_DER {       
        printf("Operación: Coseno\n");
        $$ = cos($3);
    }
    | TAN PARENTESIS_IZQ expresion PARENTESIS_DER {        
        printf("Operación: Tangente\n");
        $$ = tan($3);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Calculadora (ingrese 'e' para salir)\n");
    do {
        yyin = stdin;
        yyparse();
    } while (!salida);

    printf("Programa terminado.\n");
    return 0;
}
