#include<stdio.h>
#include<stdlib.h>
#include "task2.h"

static int regCount=-1;

int getReg(void){
    regCount++;
    if(regCount>=20){
        printf("Out of registers\n");
        exit(1);
    }
    return regCount;
}

void freeReg(void) {
    if (regCount >= 0) regCount--;
}

int getVarAddr(char *varname){
    return (4096+varname[0]-'a');
}

void codeGenRead(tnode* t, FILE *fp){
    int p=getReg();
    int q=getReg();
    int addr = getVarAddr(t->left->varname);
    fprintf(fp, "MOV R%d, %d\n", p, addr); 
    fprintf(fp, "MOV R%d, \"Read\"\n", q); 
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "MOV R%d, -1\n", q);           
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "PUSH R%d\n", p);            // Pushing into Address 
    fprintf(fp, "PUSH R%d\n", q);                 
    fprintf(fp, "PUSH R%d\n", q);                 
    fprintf(fp, "CALL 0\n");
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    freeReg(); // q
    freeReg(); // p
}

void codeGenWrite(tnode* t, FILE *fp){
    int p=codeGenExpr(t->left,fp);
    int q= getReg();
    fprintf(fp, "MOV R%d, \"Write\"\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "MOV R%d, -2\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "PUSH R%d\n", p);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "CALL 0\n");
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    fprintf(fp, "POP R%d\n", q);
    freeReg(); // q
    freeReg(); // p
}

void codeGenExit(FILE *fp){
    int q = getReg();
    fprintf(fp, "MOV R%d, \"Exit\"\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "MOV R%d, -2\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "PUSH R%d\n", q);
    fprintf(fp, "CALL 0\n");
    freeReg();
}

int codeGenExpr(tnode *t, FILE *fp){
    if(t->nodetype==NODE_NUM){
        int r=getReg();
        fprintf(fp, "MOV R%d, %d\n", r, t->val);
        return r;
    }
    if (t->nodetype == NODE_ID) {
        int r = getReg();
        int addr = getVarAddr(t->varname);
        fprintf(fp, "MOV R%d, [%d]\n", r, addr);
        return r;
    }

    int r1 = codeGenExpr(t->left, fp);
    int r2 = codeGenExpr(t->right, fp);
        switch (t->nodetype) {
            case NODE_PLUS:
                fprintf(fp, "ADD R%d, R%d\n", r1, r2);
                break;
            case NODE_MINUS:
                fprintf(fp, "SUB R%d, R%d\n", r1, r2);
                break;
            case NODE_MUL:
                fprintf(fp, "MUL R%d, R%d\n", r1, r2);
                break;
            case NODE_DIV:
                fprintf(fp, "DIV R%d, R%d\n", r1, r2);
                break;
            default:
                printf("Invalid expression node\n");
                exit(1);
    }

    freeReg();   // free r2
    return r1;   // result in r1
}

void codeGen(tnode *t, FILE *fp){
    if(t==NULL) return;

    switch(t->nodetype){
        case NODE_CONNECTOR:
            codeGen(t->left,fp);
            codeGen(t->right,fp);
            break;
        
        case NODE_READ:
            codeGenRead(t,fp);
            break;

        case NODE_WRITE:
            codeGenWrite(t,fp);
            break;

        case NODE_ASSIGN:
            int addr = getVarAddr(t->left->varname);
            int r = codeGenExpr(t->right,fp);
            fprintf(fp,"MOV [%d], R%d\n",addr,r);
            freeReg();
            break;
        
        default :
            printf("Invalid statement node\n");
            exit(1);
    }
}