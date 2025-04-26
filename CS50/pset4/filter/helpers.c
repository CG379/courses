#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    //Grabs each row (i) and column (j) of each pixel
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            //Averages out the colours in each pixel then sets the red, green and blue to that value
            int red = image[i][j].rgbtRed;
            int green = image[i][j].rgbtGreen;
            int blue = image[i][j].rgbtBlue;

            int average = round((red + green + blue) / 3.0);
            image[i][j].rgbtRed = image[i][j].rgbtGreen = image[i][j].rgbtBlue = average;
        }

    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    //Grabs each row (i) and column (j) of each pixel
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            //Uses the sepia equation to output the sepia versions of the colours
            RGBTRIPLE *pixel = &image[i][j];
            int sepiaRed = round(0.189 * (*pixel).rgbtBlue + 0.769 * (*pixel).rgbtGreen + 0.393 * (*pixel).rgbtRed);
            int sepiaGreen = round(0.168 * (*pixel).rgbtBlue + 0.686 * (*pixel).rgbtGreen + 0.349 * (*pixel).rgbtRed);
            int sepiaBlue = round(0.131 * (*pixel).rgbtBlue + 0.534 * (*pixel).rgbtGreen + 0.272 * (*pixel).rgbtRed);
            //To make sure that the values don't exceed 255
            if (sepiaRed > 255)
            {
                sepiaRed = 255;
            }
            if (sepiaGreen > 255)
            {
                sepiaGreen = 255;
            }
            if (sepiaBlue > 255)
            {
                sepiaBlue = 255;
            }
            //Makes the pixels the sepia value
            (*pixel).rgbtBlue = sepiaBlue;
            (*pixel).rgbtGreen = sepiaGreen;
            (*pixel).rgbtRed = sepiaRed;
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        // Reverse width array
        int n = width;
        int end = width - 1;

        for (int j = 0; j < n / 2; j++)
        {
            RGBTRIPLE tmp = image[i][j];
            image[i][j] = image[i][end];
            image[i][end] = tmp;
            end--;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    //Create a tempoary array with the values
    RGBTRIPLE temp[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            temp[i][j] = image[i][j];
        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int sum_blue;
            int sum_green;
            int sum_red;
            float counter;
            sum_blue = sum_green = sum_red = counter = 0;

            //For the corners of the image
            //Bottom right
            if (i >= 0 && j >= 0)
            {
                sum_red += temp[i][j].rgbtRed;
                sum_green += temp[i][j].rgbtGreen;
                sum_blue += temp[i][j].rgbtBlue;
                counter++;
            }
            //bottom left
            if (i >= 0 && j - 1 >= 0)
            {
                sum_red += temp[i][j - 1].rgbtRed;
                sum_green += temp[i][j - 1].rgbtGreen;
                sum_blue += temp[i][j - 1].rgbtBlue;
                counter++;
            }
            //top right
            if (i - 1 >= 0 && j >= 0)
            {
                sum_red += temp[i - 1][j].rgbtRed;
                sum_green += temp[i - 1][j].rgbtGreen;
                sum_blue += temp[i - 1][j].rgbtBlue;
                counter++;
            }
            //top left
            if (i - 1 >= 0 && j - 1 >= 0)
            {
                sum_red += temp[i - 1][j - 1].rgbtRed;
                sum_green += temp[i - 1][j - 1].rgbtGreen;
                sum_blue += temp[i - 1][j - 1].rgbtBlue;
                counter++;
            }
            //For the edges of the images
            //bottom edge
            if ((i >= 0 && j + 1 >= 0) && (i >= 0 && j + 1 < width))
            {
                sum_red += temp[i][j + 1].rgbtRed;
                sum_green += temp[i][j + 1].rgbtGreen;
                sum_blue += temp[i][j + 1].rgbtBlue;
                counter++;
            }
            //top edge
            if ((i - 1 >= 0 && j + 1 >= 0) && (i - 1 >= 0 && j + 1 < width))
            {
                sum_red += temp[i - 1][j + 1].rgbtRed;
                sum_green += temp[i - 1][j + 1].rgbtGreen;
                sum_blue += temp[i - 1][j + 1].rgbtBlue;
                counter++;
            }
            //left edge
            if ((i + 1 >= 0 && j >= 0) && (i + 1 < height && j >= 0))
            {
                sum_red += temp[i + 1][j].rgbtRed;
                sum_green += temp[i + 1][j].rgbtGreen;
                sum_blue += temp[i + 1][j].rgbtBlue;
                counter++;
            }
            //right edge
            if ((i + 1 >= 0 && j - 1 >= 0) && (i + 1 < height && j - 1 >= 0))
            {
                sum_red += temp[i + 1][j - 1].rgbtRed;
                sum_green += temp[i + 1][j - 1].rgbtGreen;
                sum_blue += temp[i + 1][j - 1].rgbtBlue;
                counter++;
            }
            //centre pixles
            if ((i + 1 >= 0 && j + 1 >= 0) && (i + 1 < height && j + 1 < width))
            {
                sum_red += temp[i + 1][j + 1].rgbtRed;
                sum_green += temp[i + 1][j + 1].rgbtGreen;
                sum_blue += temp[i + 1][j + 1].rgbtBlue;
                counter++;
            }
            image[i][j].rgbtRed = round(sum_red / counter);
            image[i][j].rgbtGreen = round(sum_green / counter);
            image[i][j].rgbtBlue = round(sum_blue / counter);
        }
    }
    return;
}
