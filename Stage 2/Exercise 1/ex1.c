#include <stdio.h>
#include <stdlib.h>
#include "ex1.h"

/* memory for variables a..z */
static int mem[26] = {0};

/* convert "a".."z" into 0..25 */
static int varIndex(char *varname) {
    return varname[0] - 'a';
}

/* -------- Evaluate expression nodes (returns int value) -------- */
int evalExpr(tnode *t) {
    if (t == NULL) return 0;

    switch (t->nodetype) {

        case NODE_NUM:
            return t->val;

        case NODE_ID:
            return mem[varIndex(t->varname)];

        case NODE_PLUS:
            return evalExpr(t->left) + evalExpr(t->right);

        case NODE_MINUS:
            return evalExpr(t->left) - evalExpr(t->right);

        case NODE_MUL:
            return evalExpr(t->left) * evalExpr(t->right);

        case NODE_DIV: {
            int rightVal = evalExpr(t->right);
            if (rightVal == 0) {
                printf("Runtime error: division by zero\n");
                exit(1);
            }
            return evalExpr(t->left) / rightVal;
        }

        default:
            printf("Runtime error: invalid expression nodetype %d\n", t->nodetype);
            exit(1);
    }
}

/* -------- Execute statement nodes (no return) -------- */
void evalStmt(tnode *t) {
    if (t == NULL) return;

    switch (t->nodetype) {

        case NODE_CONNECTOR:
            evalStmt(t->left);
            evalStmt(t->right);
            break;

        case NODE_ASSIGN: {
            int value = evalExpr(t->right);
            mem[varIndex(t->left->varname)] = value;
            break;
        }

        case NODE_READ: {
            int x;
            printf("Input %s: ", t->left->varname);
            if (scanf("%d", &x) != 1) {
                printf("Runtime error: invalid input\n");
                exit(1);
            }
            mem[varIndex(t->left->varname)] = x;
            break;
        }

        case NODE_WRITE: {
            int value = evalExpr(t->left);
            printf("%d\n", value);
            break;
        }

        default:
            printf("Runtime error: invalid statement nodetype %d\n", t->nodetype);
            exit(1);
    }
}

tnode* createTree(int val, int type, char* varname,int nodetype, struct tnode *l, struct tnode *r){
    tnode* temp=(tnode*)malloc(sizeof(tnode));

    temp->val=val;
    temp->type=type;
    temp->nodetype=nodetype;
    temp->left=l;
    temp->right=r;
    if(varname!=NULL){
        temp->varname=(char*)malloc(strlen(varname)+1);
        strcpy(temp->varname,varname);
    }else{
        temp->varname=NULL;
    }
    return temp;
}


/* Helper function to print a single node */
void printNode(tnode *t) {
    if (!t) return;

    switch (t->nodetype) {
        case NODE_NUM:
            printf("[NUM:%d] ", t->val);
            break;
        case NODE_ID:
            printf("[ID:%s] ", t->varname);
            break;
        case NODE_PLUS:
            printf("[+] ");
            break;
        case NODE_MINUS:
            printf("[-] ");
            break;
        case NODE_MUL:
            printf("[*] ");
            break;
        case NODE_DIV:
            printf("[/] ");
            break;
        case NODE_ASSIGN:
            printf("[ASSIGN] ");
            break;
        case NODE_READ:
            printf("[READ] ");
            break;
        case NODE_WRITE:
            printf("[WRITE] ");
            break;
        case NODE_CONNECTOR:
            printf("[CONNECTOR] ");
            break;
        default:
            printf("[UNKNOWN] ");
    }
}

/* Level-order (BFS) traversal */
void printAST(tnode *root) {
    if (root == NULL) {
        printf("AST is empty\n");
        return;
    }

    /* Simple queue using array */
    tnode *queue[1000];
    int front = 0, rear = 0;

    queue[rear++] = root;

    while (front < rear) {
        int levelSize = rear - front;

        /* Print one level */
        for (int i = 0; i < levelSize; i++) {
            tnode *curr = queue[front++];

            printNode(curr);

            if (curr->left)
                queue[rear++] = curr->left;
            if (curr->right)
                queue[rear++] = curr->right;
        }
        printf("\n");
    }
}