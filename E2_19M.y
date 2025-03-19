%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    void yyerror(const char *s);
    int yylex();
    extern FILE *yyin;
%}

%token EMAIL

%%
email_list : email '\n' email_list
           | email '\n'
           ;

email : EMAIL { printf("Correo electrónico válido\n"); }
      ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Correo electrónico inválido\n");
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error al abrir el archivo");
            return 1;
        }
        
        printf("Analizando archivo línea por línea:\n\n");
        char linea[256];
        while (fgets(linea, sizeof(linea), yyin)) {
            printf("%s", linea);
            
            FILE *temp = fopen("temp.txt", "w");
            if (!temp) {
                perror("Error al crear archivo temporal");
                return 1;
            }
            fprintf(temp, "%s", linea);
            fclose(temp);
            
            yyin = fopen("temp.txt", "r");
            if (!yyin) {
                perror("Error al abrir archivo temporal");
                return 1;
            }
            
            if (yyparse() == 0) {
                printf("Correo válido\n");
            } else {
                printf("Correo inválido\n");
            }
            fclose(yyin);
        }
        fclose(yyin);
    } else {
        printf("Uso: %s <archivo_de_entrada>\n", argv[0]);
    }
    return 0;
}
