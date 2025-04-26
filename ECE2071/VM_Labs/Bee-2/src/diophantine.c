#include <stdio.h>

int main (void) {
    int input;
    scanf("%d",&input);

    // Equation given: 13a + 3b + 5c = 2071
    // all values of a,b,c that satisfy less than input 
    // accepted

    for (int i=0;i<input;i++){
        for (int j = 0;j<input;j++){
            for (int k = 0;k<input;k++){
                if (13*i + 3*j + 5*k == 2071){
                    printf("a=%d b=%d c=%d\n",i,j,k);
                }
            }
        }
    }
    return 0;
}