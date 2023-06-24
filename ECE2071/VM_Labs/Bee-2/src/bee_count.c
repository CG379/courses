#include <stdio.h>
#include <ctype.h>

int main (void) {
    // Open file and safety check
    FILE* script;
    script = fopen("../data/bee_movie_script.txt","r");
    if(NULL == script) {
	    printf("File can't be opened\n");
        return 1;
	}
    // Read contents and count occurrences of "bee"
    int count = 0;
    char word[] = "bee";
    int wordLen = 3;
    int match = 0;
    int prev = ' ';

    int current;
    // https://stackoverflow.com/questions/4358728/end-of-file-eof-in-c
    while((current = fgetc(script)) != EOF) {
        // Check if current character is a letter or an apostrophe
        if(isalpha(current) || current == '\'') {
            // Convert character to lowercase
            current = tolower(current);
            // Check if the current character matches the next character in the word "bee"
            if(current == word[match]) {
                match++;
                // If have matched all the characters in "bee", check if it's a valid occurrence
                if(match == wordLen) {
                    // Check if the previous character is a valid character to end a word
                    if(isalpha(prev)) {
                        count++;
                    }
                    match = 0;
                }
            } else {
                match = 0;
            }
        }
        prev = current;
    }

    // Close file and print results
    fclose(script);
    printf("There were %d occurrences of the word bee in the text.\n", count);

    return 0;
}