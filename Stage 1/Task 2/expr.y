%{
#include <stdio.h>
#include <stdlib.h>
#include "expr.h"

int yylex();
void yyerror(const char *s);

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
    FILE * fp = fopen("out.xsm","w");
    if(fp==NULL){
        printf("Cannot create out.xsm\n");
        exit(1);
    }

    fprintf(fp, "%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n",0,2056,0,0,0,0,0,0); 
    int r=codeGen(root,fp);
    fprintf(fp, "MOV [4096], R%d\nMOV R0, [4096]\n", r);
    //Write
    fprintf(fp, "MOV SP, 4095\n");
    fprintf(fp, "MOV R1, \"Write\"\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "MOV R1, -2\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "PUSH R0\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "CALL 0\n");
    fprintf(fp, "POP R0\n");
    fprintf(fp, "POP R1\n");
    fprintf(fp, "POP R1\n");
    fprintf(fp, "POP R1\n");
    fprintf(fp, "POP R1\n");
    //Exit
    fprintf(fp, "MOV R1, \"Exit\"\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "MOV R1, -2\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "PUSH R1\n");
    fprintf(fp, "CALL 0");
    fclose(fp);
    printf("out.xsm generated successfully\n");
    exit(0);
}
;

E : E '+' E { $$ = makeOperatorNode('+', $1, $3); }
  | '(' E ')' { $$ = $2; }
  | NUM { $$ = $1; }
;

%%

void yyerror(const char *s) {
    printf("Yashwanth there is an error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
