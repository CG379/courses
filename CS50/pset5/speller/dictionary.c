// Implements a dictionary's functionality
#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// Number of buckets in hash table
const unsigned int N = 300000;

// Hash table
node *table[N];

// Returns true if word is in dictionary else false
bool check(const char *word)
{
    //Find the word in the dictionary with the same number as the one supplied
    //Compare the words in the dictionary to the words typed, as seen in lecture 5
    int length = strlen(word);
    char c[length + 1];
    //Need to copy terminator of the string
    for (int i = 0, l = length + 1; i < l; i++)
    {
        c[i] = tolower(word[i]);
    }
    int hIndex = hash(c);
    if (table[hIndex] == NULL)
    {
        return false;
    }

    node *tmp = table[hIndex];

    while (tmp != NULL)
    {
        if (strcmp(c, tmp->word) == 0)
        {
            return true;
        }

        tmp = tmp->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    /*Credit to
     https://stackoverflow.com/questions/61266621/spell-checker-program-check-function-speller-cs50
     cut my original code in half
    */
    int hash = 0;
    for (int i = 0, n = strlen(word); i < n; i++)
    {
        hash = (hash << 2) ^ word[i];
    }
    return hash % N;
}

// Loads dictionary into memory, returning true if successful else false
bool load(const char *dictionary)
{
    // TODO
    //Open file
    FILE *f = fopen(dictionary, "r");//
    //Checks if if it is null
    if (f == NULL)
    {
        printf("Unable to open file.");
        return false;
    }
    char w[LENGTH + 1];
    //Reacd string from file
    while (fscanf(f, "%s", w) != EOF)
    {
        node *tmp = malloc(sizeof(node));
        if (tmp == NULL)
        {
            printf("Out of memory. Ending program.\n");
            unload();
            return false;
        }
        strcpy(tmp->word, w);
        tmp->next = NULL;

        int hIndex = hash(w);

        if (table[hIndex] != NULL)
        {
            tmp->next = table[hIndex];
            table[hIndex] = tmp;
        }
        else if (table[hIndex] == NULL)
        {
            table[hIndex] = tmp;
            tmp->next = NULL;
        }
    }
    fclose(f);
    return true;
}

// Returns number of words in dictionary if loaded else 0 if not yet loaded
unsigned int size(void)
{
    // Make variable to count the number of words loaded and for and while loop
    int size = 0;
    //Goes through the hash table and counts it
    for (int i = 0; i < N; i++)
    {
        node *t = table[i];
        while (t != NULL)
        {
            size++;
            t = t->next;
        }
    }
    return size;
}

// Unloads dictionary from memory, returning true if successful else false
bool unload(void)
{
    //From lecture:
    //Go through each bit of the hash table
    for (int i = 0; i < N; i++)
    {
        //Stops when the table is NULL, goes to the next one
        while (table[i] != NULL)
        {
            node *temp = table[i]->next;
            free(table[i]);
            table[i] = temp;
        }
    }
    return true;
}
