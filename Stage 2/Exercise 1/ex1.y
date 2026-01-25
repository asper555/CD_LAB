%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "ex1.h"

    int yylex(void);
    void yyerror();
    extern FILE* yyin;
    tnode *root;
%}

/* YYSTYPE */
%union {
    tnode *node;
}

/* Tokens */
%token <node> ID NUM
%token BEGINX ENDX READ WRITE

/* Non-terminals */
%type <node> Program Slist Stmt E

/* Operator precedence */
%left '+' '-'
%left '*' '/'

%%

Program
    : BEGINX Slist ENDX
      {
          root = $2;
          printf("Parsing Successful\n");
          printf("Executing program...\n\n");
          evalStmt(root);
          exit(0);
      }
    | BEGINX ENDX
      {
          printf("Empty program\n");
          exit(0);
      }
    ;

Slist
    : Slist Stmt ';'
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_CONNECTOR, $1, $2);
      }
    | Stmt ';'
      {
          $$ = $1;
      }
    ;

Stmt
    : READ '(' ID ')'
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_READ, $3, NULL);
      }
    | WRITE '(' E ')'
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_WRITE, $3, NULL);
      }
    | ID '=' E
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_ASSIGN, $1, $3);
      }
    ;

E
    : E '+' E
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_PLUS, $1, $3);
      }
    | E '-' E
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_MINUS, $1, $3);
      }
    | E '*' E
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_MUL, $1, $3);
      }
    | E '/' E
      {
          $$ = createTree(0, TYPE_INT, NULL, NODE_DIV, $1, $3);
      }
    | '(' E ')'
      {
          $$ = $2;
      }
    | NUM
      {
          $$ = $1;
      }
    | ID
      {
          $$ = $1;
      }
    ;

%%

void yyerror() {
    printf("Yashwanth there Is an error\n");
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            printf("Cannot open input file\n");
            return 1;
        }
    }
    yyparse();
    return 0;
}
