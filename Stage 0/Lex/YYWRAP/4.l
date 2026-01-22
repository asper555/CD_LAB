%{
    // Taking input from file first and then from console
    #include<stdio.h>
    #include<stdlib.h>
    FILE *fp;
    char * f="1.txt";
    int stage=0;
%}

number [0-9]+

%%
{number} {printf("%d\n",atoi(yytext));}
\n
%%

int yywrap(){
    if(stage==0){
        yyin=stdin;
        stage=1;
        return 0;
    }else{
        return 1;
    }
}

int main(){
    fp=fopen(f,"r");
    yyin=fp;
    yylex();
    return 0;
}