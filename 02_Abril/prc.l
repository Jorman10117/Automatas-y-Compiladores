%{
#include "y.tab.h"
int yywrap(void) { return 1; }
%}

%%

"INSERT"                { return INSERT; }
"INTO"                  { return INTO; }
"VALUES"                { return VALUES; }
"NULL"                  { return NULLVAL; }
[0-9]+                  { return NUMERO; }
(\"[^\"]*\"|\'[^\']*\') { return CADENA; }       // ✅ acepta ambas comillas
[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFICADOR; }
","                     { return COMA; }
"("                     { return PARI; }
")"                     { return PARD; }
";"                     { return PUNTOCOMA; }
[ \t\n]+                ; // ignora espacios
.                       { return yytext[0]; }
