%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER

%%

stmt:
      stmt expr '\n'   { printf("Result: %d\n", $2); }
    |
    ;

expr:
      NUMBER           { $$ = $1; }
    | expr expr '+'    { $$ = $1 + $2; }
    | expr expr '-'    { $$ = $1 - $2; }
    | expr expr '*'    { $$ = $1 * $2; }
    | expr expr '/'    {
                          if ($2 == 0)
                              yyerror("Division by zero");
                          else
                              $$ = $1 / $2;
                       }
    ;
%%

void yyerror(const char *s)
{
    printf("Error: %s\n", s);
}

int main(void)
{
    yyparse();
    return 0;
}

