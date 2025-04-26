#include <stdio.h>

int main (void) {
    // Ask for 3 inputs, 2 numbers (int) and an operator (char)
    float num1;
    float num2;
    char opperator;
    // colect inputs
    scanf("%f %c %f", &num1, &opperator,&num2);
    // operation cases
    float answer;
    if (opperator == '+'){answer = (num1+num2); printf("%f\n", answer);}
    else if (opperator == '-'){answer = (num1-num2); printf("%f\n", answer);}
    else if (opperator == '*'){answer = (num1*num2); printf("%f\n", answer);}
    else if (opperator == '/'){answer = (num1/num2); printf("%f\n", answer);}
    //else if (opperator == '%'){answer = (num1%num2); printf("%d\n", answer);}
    else {printf("Error\n"); return 1;}
    return 0;
}