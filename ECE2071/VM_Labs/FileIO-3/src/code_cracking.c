#include <stdio.h>
#include <ctype.h>

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
    int matrix[num_cols][num_rows];
    int num;

    // assign values to matrix
    for (int i = 0; i < num_cols; i++){
        for (int j = 0; j < num_rows; j++){
            if(fscanf(f,"%d",&num) == 1) {
                matrix[i][j] = num;
                // printf("[%d][%d]: %d\n",i,j,num);
            }
        }
    }

    // Read anticlockwise
    // Start at top left most
    // go down till reach bottom
    // go to right till end
    // go up till end
    // go left till end_col-1
    // go down to end_row-1
    // go to right till end - 2
    // go up till end - 2
    // Repeat till reach middle
    int current_col, current_row = 0;
    int i;
    // Nummber of rows = number of entries in each column, vice verca

    while (current_row < num_rows && current_col < num_cols){
        // Print current column top to bottom, starting at the current row
        for (i = current_col; i < num_rows; i++){
            printf("%d ", matrix[current_col][i]);
        }
        current_col++;
        // Left most column, top to bottom
        for(i = current_col; i < num_cols; i++) {
            printf("%d ", matrix[i][num_rows - 1]);
        }
        num_rows--;

        // print right most column from bottom to top
        for(i = num_rows - 1; i >= current_row; i--) {
            printf("%d ", matrix[num_cols - 1][i]);
            }
        num_cols--;

        // print top row from right to left
        for(i = num_cols - 1; i >= current_col; i--) {
            printf("%d ", matrix[i][current_row]);
        }
        current_row++;

    }
    printf("\n");



    return 0;
}