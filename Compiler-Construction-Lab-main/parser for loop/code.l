%{
#include "y.tab.h"
%}

%%

"for"        { return FOR; }
"++"         { return INC; }
"--"         { return DEC; }
"<="         { return LE; }
">="         { return GE; }
"=="         { return EQ; }
"!="         { return NE; }

[0-9]+       { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

[(){};=<>]   { return yytext[0]; }
[ \t\r\n]+   { /* skip whitespace */ }
.            { return yytext[0]; }

%%

int yywrap(void)
{
    return 1;
}