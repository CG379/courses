// Functions for listing all files in a directory
// Copyright © 2023 Copyright, Monash University
#pragma once
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

/**
 * Stores a list of all the filenames in a given directory into an array
 * @param directory A string containing the path to the directory
 * @param file_count Will store the number of files in the given directory (equal to the length of the allocated array)
 * @return A pointer to an array of strings, allocated via malloc
 * @example
 * Example Usage:
 *     int number_of_files;
 *     char **filenames  = query_filenames("my_directory", &number_of_files);
 *     for (int file_index = 0; file_index < number_of_files; file_index++) {
 *         printf("Filename: %s", filenames[file_index])
 *         free(filenames[file_index]); // make sure to free each string in the array when you are done
 *     }
 *     free(filenames); // free the array afterwards
*/
char **query_filenames(const char *directory, int *file_count)
{
    // Count number of files
    *file_count = 0;
    struct dirent *dir;
    DIR *d = opendir(directory);
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            // ignores folders and files beginning with ".", non-png files
            int filename_length = strlen(dir->d_name);
            bool is_png = filename_length > 4 && (dir->d_name[filename_length-3] == 'p') && (dir->d_name[filename_length-2] == 'n') && (dir->d_name[filename_length-1] == 'g');
            bool should_ignore = dir->d_type != DT_REG || !is_png;
            if (!should_ignore)
            {
                (*file_count)++;
            }
        }
    } else {
        fprintf(stderr, "Error, unable to open directory: %s\n", directory);
        abort();
    }

    // Allocate memory for filename pointers
    char **filenames = malloc((*file_count) * sizeof(char *));

    // Store filenames
    int file_index = 0;
    rewinddir(d);
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            // ignores folders and files beginning with ".", non-png files
            int filename_length = strlen(dir->d_name);
            bool is_png = filename_length > 4 && (dir->d_name[filename_length-3] == 'p') && (dir->d_name[filename_length-2] == 'n') && (dir->d_name[filename_length-1] == 'g');
            bool should_ignore = dir->d_type != DT_REG || dir->d_name[0] == '.' || !is_png;
            if (!should_ignore)
            {
                // Allocate memory for each string and copy it over
                filenames[file_index] = (char *)malloc(filename_length + 2);                           // TODO: double check +1
                snprintf(filenames[file_index], filename_length + 2, "%s", dir->d_name); // TODO: confirm +2
                file_index++;
            }
        }
        closedir(d);
    } else {
        fprintf(stderr, "Error, unable to open directory: %s\n", directory);
        abort();
    }

    return filenames;
}
