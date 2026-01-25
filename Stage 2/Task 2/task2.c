#include "task2.h"

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
