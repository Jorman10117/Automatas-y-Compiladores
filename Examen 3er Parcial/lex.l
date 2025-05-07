%{
#include "y.tab.h"
%}

%%
[0-9]+          { yylval = atoi(yytext); return NUM; }
"*"             { return MULT; }
"+"             { return SUMA; } 
"("             { return IPAREN; }
")"             { return CPAREN; }
[ \t]           ; 
\n              { return LINEA; }
"e"             { return EXIT; }
.               { return yytext[0]; } 
%%

int yywrap() {
    return 1;
}