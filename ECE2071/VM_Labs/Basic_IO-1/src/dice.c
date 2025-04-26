#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void){
    // Make sure it is random
    srand(time(0));
    // x%y If x is not completely divisible by y, 
    // then the result will be the remainder in the range [0, y-1]
    int roll1 = (rand() % 6) + 1;
    int roll2 = (rand() % 6) + 1;
    int sum = roll1 + roll2;
    int counter = 1;
    int startRoll = 0;


    printf("First Roll: %d\n", sum);
    // Instant win/loss conditions
    if (sum == 7 || sum == 11){
        printf("You won $10\n");
        return 0;
    }
    if (sum == 2 || sum == 3 || sum == 12) {
        printf("You lost\n");
        return 0;
    }

    startRoll = sum;
    

    while (1){
        // Next new rolls
        roll1 = (rand() % 6) + 1;
        roll2 = (rand() % 6) + 1;
        sum = roll1 + roll2;
        counter++;
        
        printf("Next Roll: %d\n",sum);

        // Exit conditions
        if (sum == startRoll){
            printf("You won $50\n");
            printf("No. of Rolls: %d\n",counter);
            return 0;
        }
        else if (sum == 7){
            printf("You lost\n");
            printf("No. of Rolls: %d\n",counter);
            return 0;
        }
    }
}