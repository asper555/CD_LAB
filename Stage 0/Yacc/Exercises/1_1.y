%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    int levels=0;
    int yylex();
    void yyerror(const char*s);

%}

%token IF ID


%%
start : stmt'\n' {exit(0);}


stmt  : IF'('IDX')' '{' {levels++;
                     printf("Entered level : %d\n",levels);
                     }
        stmt'}'{levels--;} stmt   

        | IDX;


IDX  : IDX ID| ;
%%

void yyerror(const char*s){
    printf("Error: %s\n", s);
}

int yylex() {
    char c,b;
    scanf("%c",&c);
    if(c=='i'){
        scanf("%c",&b);
        if(b=='f'){
            return IF;
        }else{
            return ID;
        }
    }

    if(c=='(' || c==')' || c=='{' || c=='}' || c=='\n'){
        return c;
    }
    return ID;
}


int main() {
    yyparse();
    return 0;
}

