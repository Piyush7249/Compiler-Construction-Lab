%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *message);
%}

%token NUMBER PLUS INVALID

%%
input:
      NUMBER PLUS NUMBER '\n' { printf("Valid expression\n"); }
    ;
%%

void yyerror(const char *message)
{
    printf("Invalid expression\n");
}

int main(void)
{
    printf("Enter an expression (example: 7+7): ");
    return yyparse();
}