%option noyywrap

%{
#include <stdio.h>
int lines = 0;
int words = 0;
int chars = 0;
%}

word    [a-zA-Z0-9]+
newline \n

%%

{word}      { words++; chars += yyleng; }
{newline}   { lines++;}


%%

int main() {
    yylex();
    printf("Lines: %d\nWords: %d\nCharacters: %d\n", lines, words, chars);
    return 0;
}
