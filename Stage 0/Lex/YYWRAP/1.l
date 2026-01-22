%option noyywrap

%{
    #include<stdio.h>
    #include<stdlib.h>
    FILE*fp;
    // file input from console or from file
%}
number [0-9]+
%%
{number} {printf("%d",atoi(yytext));}
%%
int main(int argc,char*argv[]){
    if(argc>1){
        fp=fopen(argv[0],"r");
        if(!fp){
            printf("file is not open\n");
            return 0;
        }
        yyin=fp;
    }
    else{
        if(!yyin){
            yyin=stdin;
        }
    }
    yylex();
    return 1;
}