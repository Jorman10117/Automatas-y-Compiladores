/*Programa que acepta los numeros enteros y decimales sin singo*/

%option noyywrap
%{
	#include<stdio.h>
%}

%%
[0-9]* {printf("Aceptado: %s\n", yytext);}
[0-9]*\.[0-9]* {printf("Aceptado: %s\n", yytext);}
[+-][0-9]* {printf("NO Aceptado\n");}
[+-][0-9]*\.[0-9]* {printf("NO Aceptado\n");}
%%
int main()
{
	yylex();
	return 0;
}