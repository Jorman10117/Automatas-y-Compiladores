%option noyywrap
%{
	#include<stdio.h>
%}
%%
[a-z]{2}[0-9]{6}@uaeh\.edu\.mx  { printf("Correo Electronico Correcto\n"); }
.  /* Ignora cualquier otro caracter */
%%

int main()
{
	yylex();
	return 0;
}
