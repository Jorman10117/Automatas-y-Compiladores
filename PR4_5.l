%option noyywrap
%{
	#include<stdio.h>
%}

%%
[A-Z]{4}[0-9]{6}[H,M][A-Z]{2}[A-Z]{3}[A-Z0-9]{2} { printf("CURP Correcto\n"); }
.  /*Ignora cualquier otro caracter*/
%%
int main()
{
	yylex();
	return 0;
}