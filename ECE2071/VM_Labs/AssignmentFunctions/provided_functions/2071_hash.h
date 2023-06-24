// Functions for calculating hashes
// Copyright © 2023 Copyright, Monash University
#pragma once
#include <tomcrypt.h>
#include "2071_image.h"
#include <stdint.h>

#define HASH_STRING_LENGTH sha256_desc.hashsize * 2

char *hash_sha_256_image(Image *image);
unsigned char *hashSHA256(const char *input, unsigned long inputSize);

/**
 * Hashes a given sequence of bytes using the SHA256 algorithm
 * @param image Image struct containing pixel data
 * @return A pointer to a malloc-allocated string containing the hash, of length HASH_STRING_LENGTH
 * @example
 * Example Usage:
 *     Image my_image = read_image_from_file("my_directory", "test_image.png");
 *     hash_sha_256_image(*my_image);
 *     free(image.data); // free the array afterwards
 */
char *hash_sha_256_image(Image *image)
{
    int image_data_length = image->height * image->width;
    uint8_t *input_data = malloc(image_data_length * sizeof(uint8_t));

    // Copy to input_data buffer so it is the correct type for hashing
    for (int i = 0; i < image_data_length; i++)
    {
        input_data[i] = image->data[i];
    }

    // Initial
    uint8_t *hash_result = malloc(sha256_desc.hashsize);
    // Initialize a state variable for the hash
    hash_state md;
    sha256_init(&md);
    // Process the text - remember you can call process() multiple times
    sha256_process(&md, (const uint8_t *)input_data, image_data_length); // TODO: fix calculation
    // Finish the hash calculation
    sha256_done(&md, hash_result);

    free(input_data);

    // Convert hash number to a string in hexadecimal representation
    char *hash_string = malloc((HASH_STRING_LENGTH+1) * sizeof(char));
    for (int x = 0; x < sha256_desc.hashsize; x++)
    {
        int string_length = 3; // including null terminator (gets overridden except for the last iteration)
        snprintf(hash_string+2*x, string_length, "%02x", hash_result[x]);
    }
    
    free(hash_result);

    // Return the result
    return hash_string;
}

/**
 * Hashes a given sequence of bytes using the SHA256 algorithm
 * @param input The input sequence pointer
 * @param inputSize The size of the input sequence
 * @return A malloc-allocated pointer to the resulting data. 20 bytes long.
 */
unsigned char *hashSHA256(const char *input, unsigned long inputSize)
{
    // Initial
    unsigned char *hash_result = (unsigned char *)malloc(sha256_desc.hashsize);
    // Initialize a state variable for the hash
    hash_state md;
    sha256_init(&md);
    // Process the text - remember you can call process() multiple times
    sha256_process(&md, (const unsigned char *)input, inputSize);
    // Finish the hash calculation
    sha256_done(&md, hash_result);
    // Return the result
    return hash_result;
}
