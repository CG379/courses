#include <stdio.h>
#include <stdlib.h>

void collatz(int n) {
    printf("%d ", n);
    // Base case
    if (n == 1) {
        return;
    } 
    // Other cases
    else if (n % 2 == 0) {
        collatz(n / 2);
    } 
    
    else {
        collatz(3 * n + 1);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Incorrect number of arguments\n");
        return 1;
    }
    int n = atoi(argv[1]);
    if (n <= 0) {
        printf("n must be positive.\n");
        return 1;
    }

    collatz(n);
    printf("\n");
    return 0;
}

