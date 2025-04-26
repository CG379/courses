/*
you will report the file names from the known set that appear 
in the unknown set. 
take as command line arguments the directory of images to search, 
and the location of the database file created by the program from 
the previous task.

../outputs/search ../data/dataset_a/unknown_no_transform ../outputs/database.tsv

This will require your program to:
Read in the database file from Stage 1, storing the information in a data structure
For each unknown image
	Read it in
	Compute the hash, mean, and/or variance 
		(which of these you use is up to you)
	Use this hash, mean, and/or variance to identify 
		the correct match from the known set
	Print the matches to the console

In order to get maximum marks, your search program must also 
function correctly on the set of images in the unknown_transformed set, 
which contains images that have been flipped/mirrored/rotated in 
different ways.

less than 40 ms

You are required to write a maximum 500 word short report 
(to be submitted in src/report.txt) discussing the merits of 
the search algorithm you choose to use, and comparing it to 
one other search algorithm discussed in this unit.
*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "stats.h"
#include "transformations.h"
#include "provided_functions/2071_files.h"
#include "provided_functions/2071_hash.h"
#include "provided_functions/2071_image.h"

typedef struct node {
    char *name;
	char *hash;
    struct node *left;
    struct node *right;
} Node;



char** get_hashes(Image* image){
	char** hashes = malloc(sizeof(char*)*8);
	// mem check
	 if (hashes == NULL){
		printf("Memory Error\n");
		return NULL;
	}	
    // All regular rotations
    for (int i = 0; i < 4; i++){
        char *hash = hash_sha_256_image(image);
        hashes[i] = hash;
        rotate_90_clockwise(image);
    }
    flip(image);
    // all flipped rotations
    for(int i = 4; i < 8; i++){
        char *hash = hash_sha_256_image(image);
        hashes[i] = hash;
        rotate_90_clockwise(image);
    }
    return hashes;
}

void insert(Node **root, char *filename, char *hash){
	// https://stackoverflow.com/questions/252782/strdup-what-does-it-do-in-c
	if (*root == NULL){
		// Add if not
        Node *new_node = malloc(sizeof(Node));
        new_node->name = strdup(filename);
        new_node->hash = strdup(hash);
        // assign
        new_node->left = NULL;
        new_node->right = NULL;
        *root = new_node;
		return;
	}
	int comp = strcmp(hash,(*root)->hash);
	if (comp < 0){
		insert(&(*root)->right, filename, hash);
	}
	else if (comp > 0){
		insert(&(*root)->left, filename, hash);
	}	
}


void search(Node *root, char *filename, char *hash){
	if (root == NULL) {
        // Tree is empty, base case
		return;  
    }
	int comp = strcmp(hash, root->hash);
	if (comp == 0) {
    	printf("%s\t%s\n", filename, root->name);
		return;
		//printf("\t%s\t%s\n",)
	} 
	else if (comp < 0) {
    	search(root->right, filename, hash);
	} 
	else {
   		search(root->left, filename, hash);
	}
}


int main(int argc, char *argv[])
{
	// arg check
	if (argc != 3){
		printf("Wrong amount of arguments\n");
		return 1;
	}
	
	FILE* f = fopen(argv[2],"r");
	//file check
	if (f==NULL){
		printf("Could not open file\n");
		return 2;
	}

	Node *head = NULL;
	float mean, variance;
	char filename[20];
	char hash[50];
	// Skip first line

    char line[120];
    fgets(line, 120, f); // skip first line

    while (fgets(line, 120, f) != NULL) {
        if (sscanf(line, "%s\t%f\t%f\t%s\n", filename, &mean, &variance, hash) == 4) {
            insert(&head, filename, hash);
        }
    }
	fclose(f);
	//printf("%f\t%f\n",head->mean,head->variance);
	int file_count;
    char **filenames = query_filenames(argv[1], &file_count);
	printf("unknown\tknown\n");
	Image image;
	for (int i = 0; i < file_count; i++){
		//Image *image = malloc(sizeof(Image));
        image = read_image_from_file(argv[1],filenames[i]);
		
		// compute stuff
		char **hashes = get_hashes(&image);

		for (int j = 0; j < 8; j++){
		// search
		//printf("%s\n",hash[j]);
			search(head,filenames[i],hashes[j]);
			free(hashes[j]);
		}
		//printf("%f\t%f\n",mean,var);
		free(hashes);
	}
	return 0;
}



/*
fgets alt: faster/less overhead than fscanf?
	char line[256];

	// Skip first line
	fgets(line, sizeof(line), f);

	// Parse remaining lines
	while (fgets(line, sizeof(line), f) != NULL) {
		char filename[100], hash[100];
		float mean, variance;
		sscanf(line, "%s\t%f\t%f\t%s\n", filename, &mean, &variance, hash);
		insert(&head, filename, mean, variance, hash);
	}

Node *current = *head;
    Node *parent = NULL;
    while (current !=NULL){
        parent = current;
        // mean checks
        if (mean < current->mean) {
            current = current->left;
        } 
        else if (mean > current->mean) {
            current = current->right;
        } 
        // Mean is the same
        else {
            // var checks
            if (variance < current->variance) {
                current = current->left;
            } 
            else if (variance > current->variance) {
                current = current->right;
            }
            // Variance is the same
            else {
                if (current->same != NULL){
                    for (Node *same = current->same; same != NULL; same = same->same){
                        for (int i = 0; i < 8; i++){
                            if (strcmp(hash, same->hash[i]) == 0){
                                printf("%s\t%s\n",filename,same->name);
                                return;
                            }
                        }
					}
				}
            current = current->same;
            }
        }
    }



// -1 if a is smaller
// 0 if both are equal
// 1 if a is larger
int compare_floats(float a, float b) {
    // float comp mession up insert and search
	float epsilon = 0.0001; 
    float diff = a - b;
    if (diff < -epsilon) {
        return -1;
    } 
	else if (diff > epsilon) {
        return 1;
    } 
	else {
        return 0;
    }
}
*/