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
    struct Node *next;
};

void insert(struct Node **head, char *name, int value, char *unit, int quantity, float price);
void removeComp(struct Node **head, char *name, int value, char *unit, int quantity);
struct Node *search(struct Node **head, char *name, int value, char *uint);
void print(struct Node **head);
void export(struct Node **head, char *filename);
void quit();

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
            insert(&head, name, value, unit, quantity, price);
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
            searched = search(&head,name,value,unit);
            if (searched == NULL){
                printf("Could not find component\n");
            }
            else{
                printf("Component: %s %d %s, quantity: %d, price: %.2f\n",searched->name,searched->value,searched->unit,searched->quantity, searched->price);
            }
        }
        // print
        else if (strcmp(command, "print")==0){
            print(&head);
        }
        // export
        else if (strcmp(command, "export")==0){
            char path[50];
            scanf(" %s", path);
            export(&head,path);
        }
        // quit
        else if (strcmp(command, "quit")==0){
            quit(&head);
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


void insert(struct Node **head, char *name, int value, char *unit, int quantity, float price){
    // Check if in list
    struct Node *current = *head;
    while (current != NULL){
        if (strcmp(current->name,name) == 0 && current->value == value && strcmp(current->unit,unit) == 0){
            current->quantity += quantity;
            current->price = price;
            return;
        }
        current = current->next;
    }
    
    // Add if not
    struct Node *new_node = (struct Node*) malloc(sizeof(struct Node));
    // Error if not allocate memory
    new_node->name = (char*) malloc(strlen(name)+1); 
    strcpy(new_node->name, name);
    new_node->unit = (char*) malloc(strlen(unit)+1);
    strcpy(new_node->unit, unit); 

    new_node->value = value;
    new_node->quantity = quantity;
    new_node->price = price;
    new_node->next = *head;

    *head = new_node;
}

void removeComp(struct Node **head, char *name, int value, char *unit, int quantity){
    struct Node *current = *head;
    struct Node *prev = NULL;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0 && current->value == value &&
            strcmp(current->unit, unit) == 0) {
            
            current->quantity -= quantity;
            
            if (current->quantity <= 0) {
                // First node
                if (prev == NULL) {
                    *head = current->next;
                } 
                // Any other node
                else {
                    prev->next = current->next;
                }
                // Free vars
                free(current->name);
                free(current->unit);
                free(current);
            }
            break;
        }
        prev = current;
        current = current->next;
    }
}

struct Node *search(struct Node **head, char *name, int value, char *unit) {
    struct Node *current = *head;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0 && current->value == value && strcmp(current->unit, unit) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}


void print(struct Node **head) {
    struct Node *current = *head;
    while (current != NULL) {
        printf("Component: %s %d %s, quantity: %d, price: %.2f\n", current->name, current->value, current->unit, current->quantity, current->price); 
        current = current->next;
    }
}

void export(struct Node **head,char *filename) {
    FILE *fp = fopen(filename, "w");
    if (fp == NULL) {
        printf("Error: Could not open file for writing.\n");
        return;
    }
    struct Node *current = *head;
    while (current != NULL) {
        fprintf(fp, "%s,%d,%s,%d,%.2f\n", current->name, current->value, current->unit, current->quantity, current->price);
        current = current->next;
    }
    fclose(fp);
}

void quit(struct Node **head) {
    struct Node *current = *head;
    while (current != NULL) {
        struct Node *temp = current;
        current = current->next;
        free(temp->name);
        free(temp->unit);
        free(temp);
    }
}