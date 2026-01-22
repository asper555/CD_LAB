%{
    #include<stdio.h>
    #include "y.tab.h"  
    #include<string.h>  
    int yywrap();
%}

var     [a-zA-Z]+  

%%
{var}      {strcpy(yylval.str,yytext); return var;}
\n       {return '\n';}
[(|)|+|*] {return *yytext;}
.
%%

int yywrap(){
    return 1;
}