#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct SongInfo{
    // Use pointers to allow the strings to have variable lengths
    char* name;
    char* artist;
    char* album;
    // Only small numbers are needed
    int duration;
    int year;
    // int has min range of -32767 to +32767, 
    // highest number is at least 10^9. Need more space to store than int
    long int listens;
}SongInfo;

int main (int argc, char *argv[]) {
    // Arg check
    if (argc != 2) {
        printf("Error: Incorrect number of arguments\n");
        return 1;
    }
    
    // File open and check
    FILE* f = fopen(argv[1],"r");
    if (f == NULL){
        printf("Error: Cannot open file\n");
        return 1;
    }
    int max = 31;
    int num_songs = 0;

    char name[50], artist[50], album[50];
    int duration, year;
    long int listens;


    // Store all of the info in the struct
    struct SongInfo songs[max];
    // Should i check for spaces instead of hard coding?
    while(fscanf(f, "%s %s %s %d %d %ld", name, artist, album, &duration, &year, &listens) == 6 && num_songs < max){
        // Allocate correct length of strings, add 1 for string terminator
        songs[num_songs].name = malloc(strlen(name)+1);
        songs[num_songs].artist = malloc(strlen(artist)+1);
        songs[num_songs].album = malloc(strlen(album)+1);

        // Store values
        strcpy(songs[num_songs].name, name);
        strcpy(songs[num_songs].artist, artist);
        strcpy(songs[num_songs].album, album);
        songs[num_songs].duration = duration;
        songs[num_songs].year = year;
        songs[num_songs].listens = listens;
        num_songs++;
    }
    fclose(f);
    

// Maybe TODO: Make more efficient?
// Crappy bubble sort
for (int i = 0; i < num_songs - 1; i++) {
    for (int j = 0; j < num_songs - 1; j++) {
        if (songs[j].listens < songs[j+1].listens) {
            // swap
            struct SongInfo temp = songs[j];
            songs[j] = songs[j+1];
            songs[j+1] = temp;
        }
    }
}

    for (int i=0;i<5;i++){
        printf("%s - %s, %s (%d - %ld)\n",songs[i].name,
        songs[i].artist,songs[i].album,
        songs[i].year,songs[i].listens);
    } 

    // Free memory for allocated bits
    for (int i = 0; i < num_songs; i++) {
        free(songs[i].name);
        free(songs[i].artist);
        free(songs[i].album);
    }
    
    return 0;
}