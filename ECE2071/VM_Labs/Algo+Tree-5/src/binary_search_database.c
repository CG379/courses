#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*
Name (E.g., “resistor”, “capacitor”, “LED”, etc.)
Value (E.g., 100, 10, 80, etc.) This will always be a whole number
Unit of measurement (E.g., “R”, “nF”, “mcd”, etc.)
Quantity
Price in dollars (E.g., 0.15, 2.00, etc)
*/
struct Node {
    char *name;
    int value;
    char *unit;
    int quantity;
    float price;
    struct Node *left;
    struct Node *right;
};

struct Node* insert(struct Node **root, char *name, int value, char *unit, int quantity, float price);
void removeComp(struct Node **head, char *name, int value, char *unit, int quantity);
struct Node *search(struct Node *root, char *name, int value, char *unit);
void print(struct Node *root);
void export(struct Node *root, FILE* fp);
void quit(struct Node *root);

int main(void){
    struct Node *head = NULL;
    char command[20];
    char name[20];
    char unit[10];
    char filename[50];

    while (strcmp(command, "quit")!=0){
        printf("Enter your command: ");
        scanf(" %s", command);
        // Insert
        if(strcmp(command, "insert")==0){
            int value, quantity;
            float price;

            scanf(" %s %d %s %d %f",name, &value, unit, &quantity, &price);
            head = insert(&head, name, value, unit, quantity, price);
        }
        // remove
        else if (strcmp(command, "remove")==0){
            int value, quantity;
            scanf(" %s %d %s %d", name, &value, unit , &quantity);
            removeComp(&head,name,value,unit,quantity);
        }
        // search
        else if (strcmp(command, "search")==0){
            int value;
            struct Node *searched;
            scanf(" %s %d %s", name, &value, unit);
            searched = search(head,name,value,unit);
            if (searched == NULL){
                printf("Could not find component\n");
            }
            else{
                printf("Component: %s %d %s, quantity: %d, price: %.2f\n",searched->name,searched->value,searched->unit,searched->quantity, searched->price);
            }
        }
        // print
        else if (strcmp(command, "print")==0){
            print(head);
        }
        // export
        else if (strcmp(command, "export")==0){
            char path[50];
            scanf(" %s", path);
            FILE *fp = fopen(path, "w");
            if (fp == NULL) {
                printf("Error: Could not open file for writing.\n");
            }
            else{
            export(head,fp);
            fclose(fp);
            }
        }
        // quit
        else if (strcmp(command, "quit")==0){
            quit(head);
            break;
        }
        else{
            // Continue to next line if the input is unknown
            // https://stackoverflow.com/questions/23556928/how-can-i-use-scanf-to-get-input-from-the-next-line-of-input-data
            scanf("%*[^\n]");
            printf("Error\n");

        }
    }
    return 0;
}


struct Node* insert(struct Node **root, char *name, int value, char *unit, int quantity, float price){
    // Base case
    if (*root == NULL) {
        // Add if not
        struct Node *new_node = (struct Node*) malloc(sizeof(struct Node));
        // Error if not allocate memory
        new_node->name = (char*) malloc(strlen(name)+1);
        strcpy(new_node->name, name);
        new_node->unit = (char*) malloc(strlen(unit)+1);
        strcpy(new_node->unit, unit); 
        // assign
        new_node->value = value;
        new_node->quantity = quantity;
        new_node->price = price;
        new_node->left = NULL;
        new_node->right = NULL;
        *root = new_node;
        return new_node;
    }
    
    // reuseable stuff
    // how efficient is strcomp? this worth it
    int nameComp = strcmp((*root)->name, name);
    int unitComp = strcmp((*root)->unit, unit);
    // Check if already in list
    if ((*root)->value == value && nameComp == 0 && unitComp == 0){
        (*root)->quantity += quantity;
        (*root)->price = price;
        return *root;
    }

    //Check comp name then
    //  Check comp units then
    //      Check comp value
    //          if same update value

    // go left if "smaller" go right if larger
    //left
    if (nameComp > 0 || (nameComp == 0 && unitComp > 0) || (nameComp == 0 && unitComp == 0 && value < (*root)->value)) {
        (*root)->left = insert(&((*root)->left), name, value, unit, quantity, price);
    } 
    // right
    else {
        (*root)->right = insert(&((*root)->right), name, value, unit, quantity, price);
    }
    return *root;
}


void removeComp(struct Node **head, char *name, int value, char *unit, int quantity) {
    if (*head == NULL) {
        // Component not found
        printf("Error: Could not find component to remove\n");
        return;
    }

    // Find the component to remove
    struct Node *current = *head;
    struct Node *parent = NULL;
    while (current != NULL) {
        int nameComp = strcmp(current->name, name);
        int unitComp = strcmp(current->unit, unit);

        if (current->value == value && nameComp == 0 && unitComp == 0) {
            // Component found, remove it
            if (current->quantity > quantity) {
                // Decrease quantity
                current->quantity -= quantity;
            } 
            else if (current->quantity <= quantity) {
                // Remove node
                if (parent == NULL) {
                    // Removing the head node
                    *head = NULL;
                } else if (parent->left == current) {
                    parent->left = NULL;
                } else {
                    parent->right = NULL;
                }
                free(current->name);
                free(current->unit);
                free(current);
            } 
            return;
        } 
        else if (nameComp > 0 || (nameComp == 0 && unitComp > 0) || (nameComp == 0 && unitComp == 0 && value < current->value)) {
            parent = current;
            current = current->left;
        } 
        else {
            parent = current;
            current = current->right;
        }
    }
}

struct Node *search(struct Node *root, char *name, int value, char *unit) {
    if (root == NULL){
    return NULL;
    }
    if (strcmp(root->name,name)==0 && strcmp(root->unit,unit)==0 && root->value == value){
        return root;
    }
    // > 0 mean first one before second one
    if (strcmp(root->name,name) > 0 || strcmp(root->unit,unit) > 0 || value < root->value){
        return search(root->left, name,value,unit);
    }
    // < 0 mean first one after second one
    else {
        return search(root->right, name,value,unit);
    }

}


void print(struct Node *root) {
    // Depth first traversal
    if (root != NULL) {
        print(root->left);
        printf("Component: %s %d %s, quantity: %d, price: %.2f\n", root->name, root->value, root->unit, root->quantity, root->price);
        print(root->right);
    }
}

void export(struct Node *root,FILE* fp) {
    if (root != NULL) {
        export(root->left,fp);
        fprintf(fp,"%s %d %s %d %f\n", root->name, root->value, root->unit, root->quantity, root->price);
        export(root->right,fp);
    }
}

void quit(struct Node *root) {
    if (root!= NULL){
        quit(root->left);
        quit(root->right);
        free(root->name);
        free(root->unit);
        free(root);
    }
}