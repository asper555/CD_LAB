#include<stdio.h>
#include<stdlib.h>
#include "expr.h"

static int regCount=-1;

int getReg(){
    regCount++;
    if(regCount>=20){
        printf("Out of Registers\n");
        exit(1);
    }
    return regCount;
}

void freeReg(){
    regCount--;
}

int codeGen(tnode*t,FILE*fp){
    int r1,r2;

    if(t->op==NULL){  // node is leaf and number is stored there
        int r=getReg();
        fprintf(fp,"MOV R%d, %d\n",r,t->val);
        return r;
    }

    r1=codeGen(t->left,fp);
    r2=codeGen(t->right,fp);

    if (t->op[0] == '+') {
        fprintf(fp, "ADD R%d, R%d\n", r1, r2);
    }else{
        printf("Unknown operator: %s\n", t->op);
        exit(1);
    }

    freeReg();
    return r1;
}