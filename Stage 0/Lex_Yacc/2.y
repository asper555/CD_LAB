%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex();
    void yyerror();
%}

%union {
    char str[100];
}

%token  <str> var
%left '+'
%left '*'

%%
start : expr'\n' {printf("\n"); exit(1);}

expr  : expr '+' expr {printf("+ ");}
        |expr '*' expr {printf("* ");}
        | '(' expr ')'
        | var      {printf("%s ",$1);}
        ;

%%

void yyerror(){
    printf("Error\n");
}

int main(){
    yyparse();
    return 1;
}