%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
%}

%%
[A-Z]+ {
	int i;
	for(i = 0; i < strlen(yytext); i++){
		printf("%c", yytext[i]+32);
	}
	printf(" ");
	printf("\n");
       }	
.
%%
int main()
{
	yylex();
	return 0;
}