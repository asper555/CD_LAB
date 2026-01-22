%option noyywrap

%{
    #include<stdio.h>
%}

word [a-zA-Z]+




%%
{word}  {if(yyleng == 3 && yytext[0]=='A') printf("%s\n",yytext);}
\n

%%


int main(){
    yylex();
    return 0;
}