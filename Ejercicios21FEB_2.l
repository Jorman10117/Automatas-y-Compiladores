/*Programa que acepta palabras formadas por {0,1} que inicien o terminen con 00*/

%option noyywrap
%{
	#include<stdio.h>
%}

%%
00[0-1]* {printf("Aceptado: %s\n", yytext);}
[0-1]*00 {printf("Aceptado: %s\n", yytext);}
[0-1]* {printf("NO Aceptado\n", yytext);}
%%
int main()
{
	yylex();
	return 0;
}