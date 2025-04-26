#include <stdio.h>
#include <cs50.h>

int main(void)
{
    //Gets the users name 
    string name = get_string("What is your name?\n");
    //Prints the maeesage with their name on the screen
    printf("Hello, %s\n", name);
}