/*Programa que identifica 5 palabras reservadas de JAVA*/

%option noyywrap
%{
	#include<stdio.h>
%}

%%
while {printf("Aceptado: %s\n", yytext);}
catch {printf("Aceptado: %s\n", yytext);}
boolean {printf("Aceptado: %s\n", yytext);}
class {printf("Aceptado: %s\n", yytext);}
extends {printf("Aceptado: %s\n", yytext);}
.
%%
int main()
{
	yylex();
	return 0;
}