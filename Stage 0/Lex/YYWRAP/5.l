%{
    // Taking input twice from console
    #include<stdio.h>
    #include<stdlib.h>
    int stage=0;
%}

number [0-9]+

%%
{number} {printf("%d\n",atoi(yytext));}
\n
%%

int yywrap(){
    if(stage==0){
        clearerr(stdin);  // Used to clear console
        yyin=stdin;
        stage=1;
        return 0;
    }else{
        return 1;
    }
}

int main(){
    yyin=stdin;
    yylex();
    return 0;
}