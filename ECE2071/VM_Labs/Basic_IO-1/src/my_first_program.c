#include <stdio.h>
#include <math.h>


int addNumbers(int a, int b){
        return a + b;
}

int main() {
    printf("My first program in C\n");


    // defining the key variables
    int v1 = 4;
    float v2 = 5.6;
    int v3 = 10;
   
    // check that v1 is bigger than v2
    int checkVal = v1 > v2;
    // print the results
    if (checkVal > 0) {
        printf("V1 is greater than V2\n");
    }
    else{
        printf("V1 is smaller than V2\n");
    }
    //calling an addition function
    int sum = addNumbers(v1, v3);
    printf("The sum of V1 and V3 is %d\n",sum);


    return 0;
}

