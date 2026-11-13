%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

static int temp_count = 0;

static char *new_temp(void)
{
    char name[32];
    snprintf(name, sizeof(name), "t%d", ++temp_count);
    return strdup(name);
}
%}

%union {
    char *text;
}

%token <text> ID NUMBER
%type  <text> expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
    expr {
        printf("Result: %s\n", $1);
        free($1);
    }
;

expr:
      expr '+' expr {
          $$ = new_temp();
          printf("%s = %s + %s\n", $$, $1, $3);
          free($1); free($3);
      }
    | expr '-' expr {
          $$ = new_temp();
          printf("%s = %s - %s\n", $$, $1, $3);
          free($1); free($3);
      }
    | expr '*' expr {
          $$ = new_temp();
          printf("%s = %s * %s\n", $$, $1, $3);
          free($1); free($3);
      }
    | expr '/' expr {
          $$ = new_temp();
          printf("%s = %s / %s\n", $$, $1, $3);
          free($1); free($3);
      }
    | '-' expr %prec UMINUS {
          $$ = new_temp();
          printf("%s = 0 - %s\n", $$, $2);
          free($2);
      }
    | '(' expr ')' {
          $$ = $2;
      }
    | ID {
          $$ = $1;
      }
    | NUMBER {
          $$ = $1;
      }
;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "Syntax error: %s\n", s);
}

int main(void)
{
    printf("Enter an arithmetic expression:\n");
    return yyparse();
}