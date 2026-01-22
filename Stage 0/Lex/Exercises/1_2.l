%option noyywrap
%{
#include <stdio.h>
int intcnt = 0;
int fractioncnt = 0;
%}

inti [0-9]+
fraction {inti}"."{inti}

%%
{fraction}   { fractioncnt++; }
{inti}       { intcnt++; }
%%

int main() {
    yylex();
    printf("Integers: %d\nFractions: %d\n", intcnt, fractioncnt);
    return 0;
}