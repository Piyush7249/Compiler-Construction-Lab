%{
 //Piyush Chopade 25070521509
#include "y.tab.h"
%}

%%

[0-9]+     { return NUM; }
[\t]       ;
\n         return 0;
.          { return yytext[0]; }

%%

int yywrap()
{
    return 1;
}
