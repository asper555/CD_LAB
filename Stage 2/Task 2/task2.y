%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<ctype.h>
    #include "task2.h"
    int yylex();
    void yyerror();
    extern FILE* yyin;
    tnode*root;

%}

%union{
    tnode * node;
}

%token <node> ID NUM

%token BEGINX ENDX READ WRITE

%type <node> Program E Stmt Slist

%left '+' '-'
%left '*' '/'



%%
Program : BEGINX Slist ENDX {
                root=$2;
                FILE * fp = fopen("output.xsm","w");
                if(!fp){
                    printf("Cannot create output.xsm\n");
                    exit(1);
                }

                // Setting Header : 
                fprintf(fp, "%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n",0,2056,0,0,0,0,0,0);
                //Setting the Stack Pointer
                fprintf(fp,"MOV SP, 4122\n");
                
                codeGen(root,fp);

                codeGenExit(fp);
                fclose(fp);

                printf("Parsing Successfull\n");
                printf("output.xsm generated successfully\n");
                printf("Level Order Traversal of AST : \n");
                printAST(root);
                exit(1);}
        | BEGINX ENDX  {
                root=NULL; 
                printf("Empty program\n");
                exit(1);
                }

Slist   : Slist Stmt';'{$$= createTree(0,TYPE_INT,NULL,NODE_CONNECTOR,$1,$2);}
        | Stmt ';'{$$=$1;}

Stmt    : READ '(' ID ')' {$$= createTree(0,TYPE_INT,NULL,NODE_READ,$3,NULL);}
        | WRITE '(' E ')' {$$= createTree(0,TYPE_INT,NULL,NODE_WRITE,$3,NULL); }
        | ID '=' E {$$= createTree(0,TYPE_INT,NULL,NODE_ASSIGN,$1,$3);}


E   : E '+' E {$$= createTree(0,TYPE_INT,NULL,NODE_PLUS,$1,$3);}
    | E '-' E {$$= createTree(0,TYPE_INT,NULL,NODE_MINUS,$1,$3); }
    | E '*' E {$$= createTree(0,TYPE_INT,NULL,NODE_MUL,$1,$3); }
    | E '/' E {$$= createTree(0,TYPE_INT,NULL,NODE_DIV,$1,$3); }
    | '(' E ')'{$$=$2; }
    | NUM {$$=$1;}
    | ID {$$=$1;}
    ;
%%

void yyerror(){
    printf("Yashwanth there Is an error\n");
}

int main(int argc, char* argv[]){
    if(argc>1){
        yyin=fopen(argv[1],"r");
    }
    yyparse();
    return 0;
}