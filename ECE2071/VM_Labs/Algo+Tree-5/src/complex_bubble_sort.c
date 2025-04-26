#include <stdio.h>



void bubbleSort (int array[], int n){
    int temp;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (array[j] > array[j+1]) {
                // swap
                temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
}

int main (int argc, char *argv[]) {
    // Arg check
    if (argc != 2) {
        printf("Error: Incorrect number of arguments\n");
        return 1;
    }
    
    // File open and check
    FILE* f = fopen(argv[1],"r");
    if (f == NULL){
        printf("Error: Cannot open file\n");
        return 1;
    }
    int num_rows;
    int num_cols;
    // Get matrix dimensions
    fscanf(f,"%d",&num_rows);
    fscanf(f,"%d",&num_cols);
    // Should this by dynamic memory allocation instead?
    int matrix[num_rows][num_cols];
    int num;

    // assign values to matrix
    for (int i = 0; i < num_rows; i++){
        for (int j = 0; j < num_cols; j++){
            if(fscanf(f,"%d",&num) == 1) {
                matrix[i][j] = num;
                // printf("[%d][%d]: %d\n",i,j,num);
            }
        }
    }
    for (int i = 0; i < num_rows; i ++){
        bubbleSort(matrix[i], num_cols);
    }
    for (int i = 0; i < num_rows; i++){
        for (int j = 0; j < num_cols; j++){
            printf("%d ",matrix[i][j]);
        }
        printf("\n");
    }
    return 0;
}