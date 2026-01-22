%{
    // Taking input from console first and then from file
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
        fp=fopen(f,"r");
        yyin=fp;
        stage=1;
        return 0;
    }else{
        return 1;
    }
}

int main(){
    yylex();
    return 0;
}