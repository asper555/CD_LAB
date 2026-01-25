%option noyywrap

%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include "ex1.h"
    #include "y.tab.h"
%}

ID [a-z]
NUM [0-9]+

%%
"begin"   {return BEGINX;}
"end"   {return ENDX;}
"read"   {return READ;}
"write"   {return WRITE;}

{ID}   {char temp[2]; temp[0]=yytext[0];temp[1]='\0';
        yylval.node = createTree(0,TYPE_INT,temp,NODE_ID,NULL,NULL); 
        return ID;}
{NUM}  {yylval.node = createTree(atoi(yytext),TYPE_INT,NULL,NODE_NUM,NULL,NULL); return NUM;}

"+"   { return '+'; }
"-"   { return '-'; }
"*"   { return '*'; }
"/"   { return '/'; }
"="   { return '='; }
"("   { return '('; }
")"   { return ')'; }
";"   { return ';'; }
[ \t\n]+   ; 

%%