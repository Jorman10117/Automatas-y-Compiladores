%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int amor_cont = 0, alegria_cont = 0, esperanza_cont = 0, exito_cont = 0;
    int tristeza_cont = 0, miedo_cont = 0, enojo_cont = 0, derrota_cont = 0;
    int neutral_cont = 0;

    int positive_cont = 0;
    int negative_cont = 0;
%}

%%
querer|amar|carino|ternura|atesorar|admiracion|afecto { amor_cont++; positive_cont++; }
feliz|contento|encantado|entusiasmo|risa|euforia|placer { alegria_cont++; positive_cont++; }
optimismo|confianza|ilusion|motivacion|inspiracion { esperanza_cont++; positive_cont++; }
logro|triunfo|superacion|avance|ganar|orgullo { exito_cont++; positive_cont++; }

llanto|llorar|soledad|vacio|desesperanza|perdida|dolor { tristeza_cont++; negative_cont++; }
temor|angustia|inseguridad|panico|horror|amenaza { miedo_cont++; negative_cont++; }
ira|odio|rabia|resentimiento|frustracion|venganza { enojo_cont++; negative_cont++; }
fracaso|decepcion|humillacion|rendirse { derrota_cont++; negative_cont++; }

cambio|duda|destino|misterio|sorpresa { neutral_cont++; }

. ;
%%

int main() {
    yylex();
    
    printf("Conteo de emociones por categoría:\n");
    printf("Amor: %d\n", amor_cont);
    printf("Alegria: %d\n", alegria_cont);
    printf("Esperanza: %d\n", esperanza_cont);
    printf("Exito: %d\n", exito_cont);
    
    printf("Tristeza: %d\n", tristeza_cont);
    printf("Miedo: %d\n", miedo_cont);
    printf("Enojo: %d\n", enojo_cont);
    printf("Derrota: %d\n", derrota_cont);
    
    printf("Neutrales: %d\n", neutral_cont);
    
    printf("\nConteo de emociones general:\n");
    printf("Positivas: %d\n", positive_cont);
    printf("Negativas: %d\n", negative_cont);
    printf("Neutrales: %d\n", neutral_cont);
    
    return 0;
}
