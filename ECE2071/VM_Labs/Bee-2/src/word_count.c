#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main(int argc, char *argv[]) {
    FILE *file;

    // arg check
    if (argc != 3) {
        printf("Incorrect arguments\n");
        return 1;
    }
    // file check
    file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error: could not open file %s.\n", argv[1]);
        return 1;
    }

    int count = 0;
    int i = 0;
    char word[50];
    int c;
    // Read char by char
    while ((c = fgetc(file)) != EOF) {
        // if letter add to word
        if (isalpha(c)) {
            word[i++] = tolower(c);
        }
        // if not letter check word
        else if (i > 0) {
            word[i] = '\0';
            // 0 if same
            if (strcmp(word, argv[2]) == 0) {
                count++;
            }
            // Reset word
            i = 0;
        }
    }
    
    fclose(file);
    printf("The word %s appears %d times in file %s.\n", argv[2], count, argv[1]);

    return 0;
}
