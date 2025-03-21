%option noyywrap
%{
#include <stdio.h>
#include <string.h>

int contador = 0;
char palabra_incorrecta[] = "Poter";
char palabra_correcta[] = "Potter";
%}

%%
[a-zA-Z]+ {
    if (strcmp(yytext, palabra_incorrecta) == 0) {
        contador++;
        fprintf(yyout, "%s", palabra_correcta);
    } else {
        fprintf(yyout, "%s", yytext);
    }
}
. {
    fprintf(yyout, "%s", yytext);
}
%%

int main() {
    yyin = fopen("El_Prisionero_de_Azkaban.txt", "r");
    yyout = fopen("El_Prisionero_de_Azkaban_CORRECCION.txt", "w");

    yylex();

    printf("Se encontraron y corrigieron %d instancias de '%s'.\n", contador, palabra_incorrecta);
    printf("Se ha generado el archivo corregido.\n");
    
    return 0;
}
