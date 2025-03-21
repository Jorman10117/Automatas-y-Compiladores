%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char cad_com[] = "Poter";
int contador = 0;
FILE *inFile, *outFile;
%}

%%
[a-zA-Z]+ {
    if (strcmp(yytext, cad_com) == 0) {
        contador++;
        fprintf(outFile, "Potter");
    } else {
        fprintf(outFile, "%s", yytext);
    }
}
.|\n { 
    fputc(yytext[0], outFile);
}
%%

int main() {
    inFile = fopen("El_Prisionero_de_Azkaban.txt", "r");
    if (!inFile) {
        perror("Error al abrir el archivo de entrada");
        return 1;
    }

    outFile = fopen("El_Prisionero_de_Azkaban_CORRECCION.txt", "w");
    if (!outFile) {
        perror("Error al abrir el archivo de salida");
        fclose(inFile);
        return 1;
    }

    yyin = inFile;
    yylex();

    printf("Se encontraron y corrigieron %d instancias de 'Poter'.\n", contador);
    printf("Se ha generado el archivo corregido.\n", contador);

    fclose(inFile);
    fclose(outFile);
    
    return 0;
}
