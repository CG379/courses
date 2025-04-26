
/*
to compute and store the filename, statistics, and the appropriate hashes of 
each known image
The program should take the location of the “known” image directory as a command line argument.

The program must print the database to the console
n order to store the result in a file, you can “redirect” the output by adding 
“> outputfile.tsv” to the end of your command. 
Do not write the results to a file from within your program, 
you must only write to a file using “redirection”.
	../outputs/database ../data/dataset_a/known > ../outputs/database.tsv

Output:
file\tmean\tvariance\thash
The order of the data entries is not important
You may include additional values if you wish

The set of known images is large, so you will need to take care with your 
memory allocation in this task, but this task is not timed. 
You may consider using linked lists or dynamically allocated arrays to store 
the data you create while your program is running. 

*/
#include <stdio.h>
#include <stdlib.h>
#include "stats.h"
#include "provided_functions/2071_files.h"
#include "provided_functions/2071_hash.h"
#include "provided_functions/2071_image.h"

void print_node(Image *current, char *filename);


int main(int argc, char *argv[])
{
	// arg check
	if (argc != 2){
        printf("No directry path");
		return 1;
	}
	// Prevent + 1 leak 
	setvbuf(stdout, NULL, _IONBF, 0);

    int file_count;
    char **filenames = query_filenames(argv[1], &file_count);

    printf("file\tmean\tvariance\thash\n");
    for (int i = 0; i < file_count; i++){
        Image *image = malloc(sizeof(Image));
        *image = read_image_from_file(argv[1],filenames[i]);
        print_node(image,filenames[i]);
        free(image->data);
        free(image);
        free(filenames[i]);
    }
    free(filenames);
	return 0;
}


void print_node(Image *current, char *filename){
    // A pointer to a malloc-allocated string containing the hash, of length HASH_STRING_LENGTH
    // If we can get all transformations for a given image, then during search we 
    //won't have to transform the unknown image to ckeck
    char *hash = hash_sha_256_image(current);

    printf("%s\t%f\t%f\t%s\n",filename,
    compute_mean(current->data,current->height * current->width),
    compute_variance(current->data,current->height * current->width),hash);
    free(hash);
    }




    /*
    rotate_90_clockwise(current);
    char *hashB = hash_sha_256_image(current);
    mirror(current);
    char *hashC = hash_sha_256_image(current);
    rotate_90_anticlockwise(current);
    char *hashD = hash_sha_256_image(current);
    flip(current);
    char *hashE = hash_sha_256_image(current);
    mirror(current);
    char *hashF = hash_sha_256_image(current);
    free(hashB);
    free(hashC);
    free(hashD);
    free(hashE);
    free(hashF);
    */
    // add in extra hashes of transformed versions?

/* Pre optimised
void load_images(ImageNode **head,char *directory, char **filenames, int file_count){

    for (int i = 0; i < file_count; i++){
        Image image = read_image_from_file(directory,filenames[i]);
        if (image.data == NULL) {
            printf("Failed to load image\n");
            continue;
        }
        ImageNode *current = malloc(sizeof(ImageNode));
        
        if (current == NULL){
            printf("Memory allocation error\n");
            free(image.data);
            free(current);
            continue;
        }
        
        current->image = image;
        current->next = NULL;
        // if none in list make head
        // else add to end of list
        if (*head == NULL){
            *head = current;
        }
        else{
            ImageNode *node = *head;
            while (node->next != NULL){
                node = node->next;
            }
            node->next = current;
        } 
	}
}

void free_all(ImageNode **head, char **filenames, int file_count){
    while (*head != NULL) {
        ImageNode *current = *head;
        *head = (*head)->next;
        // Free image seems to lessen leaks?
        free(current->image.data);
        free(current);
    }
    for (int i = 0; i < file_count; i++) {
        free(filenames[i]);
    }
    free(filenames);
}


// Linked list for images
typedef struct ImageNode {
    Image image;
    struct ImageNode *next;
} ImageNode;


*/

/* Before i realised query_filenames exists, still works tho
void load_images(ImageNode **head,char *directory){
	// https://www.geeksforgeeks.org/c-program-list-files-sub-directories-directory/

    struct dirent *pic; 
    // opendir() returns a pointer of DIR type. 
    DIR *dr = opendir(directory);
  
    if (dr == NULL) 
    {
        printf("Could not open current directory\n");
        return;
    }

    while ((pic = readdir(dr)) != NULL){
        Image image = read_image_from_file(directory, pic->d_name);
        if (image.data == NULL) {
            printf("Failed to load image\n");
            continue;
        }
        ImageNode *current = malloc(sizeof(ImageNode));
        
        if (current == NULL){
            printf("Memory allocation error\n");
            free(current);
            continue;
        }
        
        current->image = image;
        current->next = NULL;
        current->name = malloc(strlen(pic->d_name) + 1);
        strcpy(current->name,pic->d_name);
        // if none in list make head
        // else add to end of list
        if (head == NULL){
            *head = current;
        }
        else{
            ImageNode *node = *head;
            while (node->next != NULL){
                node = node->next;
            }
            node->next = current;
        } 
	}
    closedir(dr);    
}
*/