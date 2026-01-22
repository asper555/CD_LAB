%{
    #include<stdio.h>
    #include "y.tab.h"
    int yywrap();
%}


%%
[a-zA-Z]  {yylval.c=yytext[0]; return CH;}
\n        {return '\n';}
[(|){|}|+|*] {return *yytext;}
.
%%

int yywrap(){
    return 1;
}