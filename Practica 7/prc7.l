%{
#include "y.tab.h"
%}

%%

"if"      { return SI; }
"then"    { return ENTONCES; }

"=="      { return OP_COMP; }
"!="      { return OP_COMP; }
">"       { return OP_COMP; }
"<"       { return OP_COMP; }
">="      { return OP_COMP; }
"<="      { return OP_COMP; }

"("       { return PARENTESIS_IZQ; }
")"       { return PARENTESIS_DER; }

[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }  // Identificadores
"{"       { return LLAVE_IZQ; }
"}"       { return LLAVE_DER; }
";"       { return PUNTO_Y_COMA; }
[ \t\n]   { /* Ignorar espacios y saltos de línea */ }
.         { printf("Carácter no reconocido: %s\n", yytext); }

%%
int yywrap() { return 1; }
