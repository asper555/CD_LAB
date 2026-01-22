#include "expr.h"

tnode* makeLeafNode(int n){
    tnode* temp = (tnode*)malloc(sizeof(tnode));
    temp->val=n;
    temp->op=NULL;
    temp->left=NULL;
    temp->right=NULL;
    return temp;
}

tnode* makeOperatorNode(char op, tnode *l, tnode *r){
    tnode* temp =(tnode*)malloc(sizeof(tnode));
    temp->val=0;
    temp->op=(char*)malloc(2);
    temp->op[0] = op;
    temp->op[1] = '\0';
    temp->left=l;
    temp->right=r;
    return temp;
}

void postfix(tnode *t){
    if(t!=NULL){
        postfix(t->left);
        postfix(t->right);
        if(t->op==NULL){
            printf("%d ",t->val);
        }else{
            printf("%s ",t->op);
        }
    }
    return;
}


void prefix(tnode *t){
    if(t!=NULL){
        if(t->op==NULL){
            printf("%d ",t->val);
        }else{
            printf("%s ",t->op);
        }
        prefix(t->left);
        prefix(t->right);
    }
    return;
}