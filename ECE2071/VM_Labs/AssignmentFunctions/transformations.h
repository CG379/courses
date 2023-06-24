// Functions for transforming images
#include "provided_functions/2071_image.h"
//#include <stdlib.h>
void rotate_90_anticlockwise(Image *image);
void rotate_90_clockwise(Image *image);
void rotate_180(Image *image);
void flip(Image *image);
void mirror(Image *image);


// Altered from previous code i wrote in a different course
void flip(Image *image){
    // keep same column, just different row
    int temp;
    for (int i = 0; i < image->height/2; i++) {
        for (int j = 0; j < image->width;j++){
            temp = image->data[i*image->width + j];
            image->data[i*image->width + j] = image->data[(image->height-i-1)*image->width + j];
            image->data[(image->height-i-1)*image->width + j] = temp;
        }
    }
}

void mirror(Image *image){
    /*
    For each row i in the image:
        a. For each column j from 0 to width/2:
        b. Swap the value of pixel (i,j) with pixel (i,width-j-1).
    */
   // keep same row, different column
   for (int i = 0; i < image->height;i++){
        for (int j = 0; j < (image->width)/2; j++){
            int temp = image->data[i* image->width + j];
            image->data[i* image->width + j] = image->data[i*image->width+ (image->width-j-1)];
            image->data[i*image->width+ (image->width-j-1)] = temp;
        }
   }
    return;
}


void rotate_180(Image *image){
    // rotate 180 = flip + mirror
    flip(image);
    mirror(image);
    return;
}


void rotate_90_anticlockwise(Image *image){
/*
height = row
width = col
    new row = cos(pi/2) * row - sin (pi/2) * col = -col
    new col = sin(pi/2) * row + cos (pi/2) * col = row
    for i in row
        for j in col
            swap (i,j) with (-j, i)

    assign new image new image l or w will not be same
*/
int *new_data = malloc(image->width * image->height * sizeof(int));
    for (int i = 0; i < image->height; i ++){
        for (int j = 0; j < image->width;j++){
            new_data[(image->width - j - 1) * image->height + i] = image->data[i * image->width + j];
        }
    }
    free(image->data);
    image->data = new_data;
    int temp = image->height;
    image->height = image->width;
    image->width = temp;
    return;
}

    /*
    height = row
    width = col
    new row = cos(-pi/2) * row - sin (-pi/2) * col = col
    new col = sin(-pi/2) * row + cos (-pi/2) * col = -row
    for i in row
        for j in col
            swap (i,j) with (j, -i)

    assign new image new image l or w will not be same
    */
void rotate_90_clockwise(Image *image){
    int temp;
    for(int i = 0; i < image->width / 2; i++){
        for(int j = i; j < image->height - i - 1; j++){
            temp = image->data[i * image->width + j];
            image->data[i * image->width + j] = image->data[(image->height - j - 1) * image->width + i];
            image->data[(image->height - j - 1) * image->width + i] = image->data[(image->height - i - 1) * image->width + (image->height - j - 1)];
            image->data[(image->height - i - 1) * image->width + (image->height - j - 1)] = image->data[j * image->width + (image->height - i - 1)];
            image->data[j * image->width + (image->height - i - 1)] = temp;
        }
    }
    temp = image->height;
    image->height = image->width;
    image->width = temp;
    return;
}
