#ifndef EX1_H
#define EX1_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TYPE_INT 1

/* ---------- AST Node Types ---------- */
#define NODE_NUM        0
#define NODE_ID         1
#define NODE_PLUS       2
#define NODE_MINUS      3
#define NODE_MUL        4
#define NODE_DIV        5
#define NODE_ASSIGN     6
#define NODE_READ       7
#define NODE_WRITE      8
#define NODE_CONNECTOR  9

/* ---------- AST Node Structure ---------- */
typedef struct tnode {
    int val;                // value for NUM
    int type;               // TYPE_INT (for now)
    char *varname;          // variable name for ID (e.g. "a")
    int nodetype;           // NODE_*
    struct tnode *left;     // left child
    struct tnode *right;    // right child
} tnode;

/* ---------- AST Construction ---------- */
tnode* createTree(
    int val,
    int type,
    char* varname,
    int nodetype,
    struct tnode *left,
    struct tnode *right
);

/* ---------- AST Debug / Visualization ---------- */
void printNode(tnode *t);
void printAST(tnode *root);

/* ---------- Evaluator (Exercise 1) ---------- */
int evalExpr(tnode *t);     // evaluates expressions
void evalStmt(tnode *t);    // executes statements

#endif
