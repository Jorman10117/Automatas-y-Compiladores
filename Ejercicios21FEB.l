/*Programa que acepta palabras que contienen la cadena ae, ai, ao, au*/

%option noyywrap
%{
	#include<stdio.h>
%}

%%
[a-z]*ae[a-z]*  { printf("Aceptado: %s\n", yytext); }
[a-z]*ai[a-z]*  { printf("Aceptado: %s\n", yytext); }
[a-z]*ao[a-z]*  { printf("Aceptado: %s\n", yytext); }
[a-z]*au[a-z]*  { printf("Aceptado: %s\n", yytext); }
[a-z]+          { printf("No Aceptado\n"); }
%%

int main() {
    yylex();
    return 0;
}