/*Programa que acepta palabras que inicien con letra mayuscula*/

%option noyywrap
%{
	#include<stdio.h>
%}

%%
[A-Z][a-z]* {printf("Aceptado: %s\n", yytext);}
[a-zA-Z]* {printf("NO Aceptado\n");}

.
%%
int main()
{
	yylex();
	return 0;
}