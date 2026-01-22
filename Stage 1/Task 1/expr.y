%{
#include <stdio.h>
#include <stdlib.h>
#include "expr.h"

int yylex();
void yyerror();

tnode* root;
%}

%union {
    tnode* node;
}

%token <node> NUM
%left '+'
%type <node> E

%%

start : E'\n' {
    root = $1;
    printf("Prefix: ");
    prefix(root);
    printf("\n");
    printf("Postfix: ");
    postfix(root);
    printf("\n");
    exit(0);
}
;

E : E '+' E { $$ = makeOperatorNode('+', $1, $3); }
  | '(' E ')' { $$ = $2; }
  | NUM { $$ = $1; }
;

%%

void yyerror() {
    printf("Yashwanth there is an error: %s\n");
}

int main() {
    yyparse();
    return 0;
}
