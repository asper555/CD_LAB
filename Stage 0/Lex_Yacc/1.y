%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex();
    void yyerror();
%}
%left '+'
%left '*'
%union{
    char c;
}

%token <c> CH

%%
s : expr'\n' {printf("\n");exit(0);}

expr : expr '+' expr {printf("+");}
        | expr '*' expr {printf("*");}
        | '(' expr ')'
        | CH   {printf("%c",$1);}
        ;

%%


void yyerror()
{
    printf("yyerror\n");
    return ;
}

int main(){
    yyparse();
    return 1;
}