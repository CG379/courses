#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main() {
    FILE *input_file, *output_file;


    // open input file
    input_file = fopen("../data/bee_movie_script.txt", "r");
    if (input_file == NULL) {
        printf("Error: could not open input file.\n");
        return 1;
    }

    // open output file
    output_file = fopen("../data/nobees.txt", "w");
    if (output_file == NULL) {
        printf("Error: could not create output file.\n");
        fclose(input_file);
        return 1;
    }
    char word[50];
    int wordLength = 50;
    int c;
    // read input file character
    int i = 0;
    // https://stackoverflow.com/questions/4358728/end-of-file-eof-in-c
    while ((c = fgetc(input_file)) != EOF) {
        // add if letter
        if (isalpha(c)) {
            word[i++] = tolower(c);
        }
        // if it's not a letter
        else if (i > 0) {
            word[i] = '\0';
            // if it not "bee", write to output file
            if (strcmp(word, "bee") != 0) {
                fprintf(output_file, "%s%c", word, c);
            }
            // Reset
            i = 0;
        }
    }

    // Close files
    fclose(input_file);
    fclose(output_file);
    return 0;
}
