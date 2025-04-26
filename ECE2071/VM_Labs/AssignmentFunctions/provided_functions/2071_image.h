// Functions for reading and writing images
// Copyright © 2023 Copyright, Monash University
#pragma once
#define STBI_ONLY_PNG // disables other image formats
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

typedef struct Image
{
    int height;
    int width;
    int *data; // pointer to an array of length image.height * image.width
} Image;

/**
 * Reads an image from the given file and directory
 * @param directory_name: Folder where the file is located 
 * @param file_name Filename of the image to read
 * @returns Image struct containing the image after it is read in
 * @example
 * Example usage:
 *   Image my_image = read_image_from_file("my_directory", "test_image.png");
 *   int pixel_value = my_image.data[71 * my_image.width + 20];
 */
Image read_image_from_file(const char *directory_name, const char *file_name)
{
    Image image;
    int bytes_per_pixel;

    // Concatentate directory_name and file_name
    int path_length = strlen(directory_name) + strlen(file_name);
    char *full_image_path = malloc(path_length + 2);                           // TODO: double check +1
    snprintf(full_image_path, path_length + 2, "%s/%s", directory_name, file_name); // TODO: confirm +2

    unsigned char *data = stbi_load(full_image_path, &image.width, &image.height, &bytes_per_pixel, 0);
    // Check if file was loaded correctly
    if (data == NULL)
    {
        fprintf(stderr, "Error: File not found or unable to be read: %s\n", full_image_path);
        fprintf(stderr, "%s\n", stbi__g_failure_reason);
        abort();
    }
    free(full_image_path);

    // Check that we are dealing with 8-bit greyscale only
    if (bytes_per_pixel != 1)
    {
        fprintf(stderr, "Error: Program designed to only work with 8-bit greyscale images\n");
        abort();
    }

    // printf("File: '%s', width: %d, height: %d, %d byte(s) per pixel\n", file_name, image.width, image.height, bytes_per_pixel);

    // Allocate space for image data
    image.data = malloc(image.width * image.height * sizeof(int));
    // Copy data into image struct
    for (int i = 0; i < image.width * image.height; i++)
    {
        image.data[i] = data[i];
    }

    stbi_image_free(data);
    return image;
}

/**
 * Saves an image to the given location
 * @param file_name Destination filename for the image
 * @param image Pointer to the image to be saved
 * @example
 * Example usage:
 *   Image my_image = read_image_from_file("my_directory", "test_image.png");
 *   write_image_to_file("my_image_copy.png", *my_image);
 */
void write_image_to_file(const char *file_name, Image *image)
{
    // Allocate space for image data
    unsigned char *data = malloc(image->width * image->height * sizeof(unsigned char));

    // Copy data into image struct
    for (int i = 0; i < image->width * image->height; i++)
    {
        data[i] = image->data[i];
    }

    int channel_count = 1;
    int stride = channel_count * image->width;
    int write_result = stbi_write_png(file_name, image->width, image->height, channel_count, data, stride);

    free(data);
}

/*
Creates a copy of the image struct
Args:
    Image *image: original image to copy
Returns:
    Image struct containing a copy of the same pixels from the original image
Example usage:
    Image my_image = read_image_from_file("my_directory", "test_image.png");
    Image copy_of_my_image = copy_image(&my_image);
*/
Image copy_image(Image *image)
{
    Image temp_image;
    temp_image.width = image->width;
    temp_image.height = image->height;
    temp_image.data = malloc(sizeof(int) * temp_image.width * temp_image.height);
    memcpy(temp_image.data, image->data, sizeof(int) * temp_image.width * temp_image.height); // copy the pixels
    return temp_image;
}

Image read_image_from_file(const char *directory_name, const char *file_name);
void write_image_to_file(const char *file_name, Image *image);
