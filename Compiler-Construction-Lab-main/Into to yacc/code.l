%{
#include "y.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
[ \t\r]+    ;
\n          { return '\n'; }
.           { return INVALID; }
%%

int yywrap(void)
{
    return 1;
}