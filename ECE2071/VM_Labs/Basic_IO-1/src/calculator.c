#include <stdio.h>

int main (void) {
    // Ask for 3 inputs, 2 numbers (int) and an operator (char)
    int num1;
    int num2;
    char opperator;
    // colect inputs
    scanf("%d %c %d", &num1, &opperator,&num2);
    // operation cases
    int answer;
    if (opperator == '+'){answer = (num1+num2); printf("%d\n", answer);}
    else if (opperator == '-'){answer = (num1-num2); printf("%d\n", answer);}
    else if (opperator == '*'){answer = (num1*num2); printf("%d\n", answer);}
    else if (opperator == '/'){answer = (num1/num2); printf("%d\n", answer);}
    else if (opperator == '%'){answer = (num1%num2); printf("%d\n", answer);}
    else {printf("Error\n"); return 1;}
    return 0;
}