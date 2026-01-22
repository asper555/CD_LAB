#ifndef EXPTREE_H
#define EXPTREE_H

#include<stdio.h>
#include<stdlib.h>
#include<string.h>


typedef struct tnode{
    int val;
    char* op;
    struct tnode* left;
    struct tnode* right;
}tnode;

tnode* makeLeafNode(int n);
tnode* makeOperatorNode(char op, tnode *l, tnode *r);

void prefix(tnode *t);
void postfix(tnode *t);

int getReg();
void freeReg();
int codeGen(tnode *t, FILE *fp);

#endif