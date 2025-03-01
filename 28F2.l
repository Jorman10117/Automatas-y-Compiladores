%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int harry_cont = 0;
int ron_cont = 0;
int hermione_cont = 0;
int dumbledore_cont = 0;
int hagrid_cont = 0;
%}

%%
Harry { harry_cont++; }
Ron { ron_cont++; }
Hermione { hermione_cont++; }
Dumbledore { dumbledore_cont++; }
Hagrid { hagrid_cont++; }
. ;
%%

int main() {
    yylex();
    
    printf("Conteo de nombres en el archivo:\n");
    printf("Harry: %d\n", harry_cont);
    printf("Ron: %d\n", ron_cont);
    printf("Hermione: %d\n", hermione_cont);
    printf("Dumbledore: %d\n", dumbledore_cont);
    printf("Hagrid: %d\n", hagrid_cont);
    
    return 0;
}
