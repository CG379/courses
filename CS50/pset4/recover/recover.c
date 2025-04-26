#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

typedef uint8_t BYTE;

int main(int argc, char *argv[])
{
    //has to supply an argument of the program quits
    if (argc != 2)
    {
        printf("Usage: ./recover image");
        return 1;
    }
    FILE *file = fopen(argv[1], "r"); //reads the file
    //if the file is empty quit
    if (file == NULL)
    {
        printf("Could not open file.\n");
        return 1;
    }
    char name[10];
    BYTE chunk[512];
    FILE *image;
    int jpgNumber = 000;
    bool fileOpen = false;

    while (fread(&chunk, 512, 1, file))
    {
        //Checks for the JPEG signs
        if ((chunk[0] == 0xff) && (chunk[1] == 0xd8) && (chunk[2] == 0xff) && ((chunk[3] & 0xf0) == 0xe0))
        {
            //Closes the previous image if it has already been written then opens a new image to write the data
            if (fileOpen)
            {
                fclose(image);
                fileOpen = false;
                sprintf(name, "%03d.jpg", jpgNumber);
                image = fopen(name, "a");
                fileOpen = true;
                jpgNumber++;
            }
            //If there are no files open create an image
            if (!fileOpen)
            {
                sprintf(name, "%03d.jpg", jpgNumber);
                image = fopen(name, "w");
                fileOpen = true;
                jpgNumber++;
            }
            //Writes the data
            fwrite(&chunk, 512, 1, image);
        }
        //If the image is bigger that 512 bytes write to the same image file
        else
        {
            if (fileOpen)
            {
                fwrite(&chunk, 512, 1, image);
            }
        }
    }
    fclose(file);
    fclose(image);
}
