%option noyywrap

%{
    #include<stdio.h> 
    int single=0;
    int multi=0;
%}

%%
"//".* {single++;}  
"/\*"([^*]|\*+[^/*])*\*+"/" {multi++;}
\n
%%

int main(){
    yylex();
    printf("%d ,  %d\n",single,multi);
    return 0;
}