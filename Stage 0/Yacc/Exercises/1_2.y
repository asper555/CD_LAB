%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<ctype.h>
    int yylex();
    void yyerror(const char*s);
    int isvalid=0;
    int prev=0;
%}

%token ID


%%
start : IDX'\n' {if(isvalid){printf("Is Valid ID\n");}else printf("Invalid ID\n"); exit(0);};
IDX   : IDX ID | ;
%%


void yyerror(const char*s){
    printf("Error: %s\n", s);
}

int yylex(){
    char c;
    scanf("%c",&c);
    if(isalpha(c) && prev==0){
        isvalid=1;
    }
        prev=1;

    if(c=='\n') return c;
    if(prev==1 && !isalnum(c)){
        isvalid=0;
    }
    
    return ID;
}

int main() {
    printf("Enter the Variable : ");
    yyparse();
    return 0;
}