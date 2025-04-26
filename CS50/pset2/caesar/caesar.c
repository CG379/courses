//Caesar cipher program
#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <stdlib.h> //Converts variables
#include <ctype.h>
//Check man.cs50.io to see if there is a function that already does this

int main(int argc, string argv[]) //For command line arguments
{
    //if there is no argument
    if (argc != 2)
    {
        printf("Missing command-line argument.");
        printf("Chipher number required and must be a continuous number.\n");
        return 1;
    }
    for (int i = 0; i < strlen(argv[1]); i++)
    {
        if (isdigit(argv[1][i]) == 0)
        {
            return 1;
        }
    }
    int cipher = atoi(argv[1]);
    //if the cipher is a valid number
    if (cipher < 0)
    {
        printf("Cipher argument must be bigger than 0.");
        return 1;
    }

    if (isdigit(*argv[1]))
    {
        string t = get_string("Text: ");
        printf("ciphertext: ");
        for (int i = 0, n = strlen(t); i < n; i++)
        {
            //If the letters are lowercase
            if (islower(t[i]))
            {
                printf("%c", (((t[i] + cipher) - 97) % 26) + 97);
            }
            //If the text is lowercase
            else if (isupper(t[i]))
            {
                printf("%c", (((t[i] + cipher) - 65) % 26) + 65);
            }
            //If any special characters appear
            else
            {
                printf("%c", t[i]);
            }
        }
        printf("\n");
        return 0;

    }
    else
    {
        return 1;
    }
}
