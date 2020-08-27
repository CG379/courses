#include <stdio.h>
#include <cs50.h>


int main(void)
{
    int size;
do
{
//Promte for user input
size = get_int("Height: ");
}
while(size < 1 || size > 8);

//Display pyramids
for (int i = 0; i < size; i++)
 {
     //Spaces, has to be > 1 so that the final row doesnt have a space
     for (int gap = size - i; gap > 1; gap--)
     {
            printf(" ");
     }
     //Hashtags
    for (int blocksl = 1; blocksl <= i + 1; blocksl++)
     {
        printf("#");
     }
    //Gap
        printf("  ");
     for (int blocksr = 1; blocksr <= i + 1; blocksr++)
     {
         printf("#");
     }
    //Need to start the new line (almost forgot)
        printf("\n");
    }
}

