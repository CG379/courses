#include <stdio.h>
#include <stdlib.h>


void bubbleSort (int array[], int n){
    int temp;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - 1; j++) {
            if (array[j] > array[j+1]) {
                // swap
                temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
}



int main(int argc, char *argv[]){
    if (argc != 2) {
        printf("Incorrect number of arguments\n");
        return 1;
    }
    FILE* fp;
    fp = fopen(argv[1],"r");
    if (fp == NULL){
        printf("Error opening file\n");
        return 2;
    }

    int num;
    int n = 0;
    int* array = NULL;
    // trying to use pointers
    while (fscanf(fp, "%d", &num) == 1) {
        array = (int*) realloc(array, (n + 1) * sizeof(int));
        *(array + n) =num;
        n++;
    }
    fclose(fp);


    bubbleSort(array, n);
    for (int i = 0; i < n; i++){
        printf("%d ", array[i]);
    }
    printf("\n");

    free(array);

    return 0;
}