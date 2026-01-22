%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include "expr.h"
#include "y.tab.h"   // include Yacc header to know yylval type
%}

%%

[0-9]+    { yylval.node = makeLeafNode(atoi(yytext)); return NUM; }

"+"       { return '+'; }
"("       { return '('; }
")"       { return ')'; }
\n   {return '\n';}
%%
