%{
#include "y.tab.h"
#include <stdio.h>
%}

%%

https|http    { return PROTOCOLO; }
www           { return SUBDOMINIO; }
mx|es|com        { return DOMINIO; }
\/            { return BARRA; }
:             { return DOSPUNTOS; }
[a-zA-Z0-9-]+ { return SEGMENTO; }
.             { return yytext[0]; }

%%

int yywrap() {
    return 1;
}