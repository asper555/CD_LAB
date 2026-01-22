%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    FILE* fp;
    char *f;
    // taking input from both files 1.txt and 2.txt
%}

number [0-9]+

%%
{number}  {printf("%d\n",atoi(yytext));}
%%

int yywrap(){
    if(strcmp(f,"1.txt")==0){
        f="2.txt";
        fp=fopen(f,"r");
        yyin=fp;
        return 0;
    }else{
        return 1;
    }
}
int main(){
    f="1.txt";
    fp=fopen(f,"r");
    yyin=fp;
    yylex();
    return 1;
}