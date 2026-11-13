%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *message);
%}

%token FOR ID NUMBER
%token INC DEC LE GE EQ NE

%left '<' '>' LE GE EQ NE

%%

input:
      for_statement
    ;

for_statement:
      FOR '(' initialization ';' condition ';' update ')' statement
      {
          printf("Valid for-loop statement\n");
      }
    ;

initialization:
      ID '=' expression
    | /* empty */
    ;

condition:
      expression '<' expression
    | expression '>' expression
    | expression LE expression
    | expression GE expression
    | expression EQ expression
    | expression NE expression
    | /* empty */
    ;

update:
      ID INC
    | ID DEC
    | INC ID
    | DEC ID
    | ID '=' expression
    | /* empty */
    ;

statement:
      ';'
    | '{' '}'
    ;

expression:
      ID
    | NUMBER
    ;

%%

void yyerror(const char *message)
{
    fprintf(stderr, "Invalid for-loop: %s\n", message);
}

int main(void)
{