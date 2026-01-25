#ifndef TASK1_H
#define TASK1_H

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define TYPE_INT 1

#define NODE_NUM 0
#define NODE_ID 1
#define NODE_PLUS 2
#define NODE_MINUS 3
#define NODE_MUL 4
#define NODE_DIV 5
#define NODE_ASSIGN 6
#define NODE_READ 7
#define NODE_WRITE 8
#define NODE_CONNECTOR 9

typedef struct tnode { 
	int val;	// value of a number for NUM nodes.
	int type;	//type of variable
	char* varname;	//name of a variable for ID nodes  
	int nodetype;  // information about non-leaf nodes - read/write/connector/+/* etc.  
	struct tnode *left,*right;	//left and right branches   
}tnode;

tnode* createTree(int val, int type, char* varname,int nodetype, struct tnode *l, struct tnode *r);
void printNode(tnode *t);
void printAST(tnode *root);

int getReg(void);
void freeReg(void);
int getVarAddr(char *varname);
void codeGen(tnode *t, FILE *fp);
int codeGenExpr(tnode *t, FILE *fp);
void codeGenRead(tnode* t, FILE *fp);
void codeGenWrite(tnode* t, FILE *fp);
void codeGenExit(FILE *fp);

#endif