#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <math.h>

//Spilts the string into individual letters and counts them

//Counts the number of words in the sentence

//Counts the number of sentences, anything the ends with "." "!" or "?"

//Index calculation: index = 0.0588 * L - 0.296 * S - 15.8

// L = Average number of letters per 100 words
// S = Average number of sentences per 100 words
float Index(float se, float w, float le);

int main(void)
{
    //Gets the user input sentence
    string text = get_string("Text: ");
    float spaces = 0;
    float l = 0;
    float sentences = 0;
    //Counts the number of spaces and sentence enders in the string
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        if (text[i] == ' ')
        {
            spaces++;
        }
        if (text[i] == '.' || text[i] == '!' || text[i] == '?')
        {
            sentences++;
        }
        if ((text[i] >= 'a' && text[i] <= 'z') || (text[i] >= 'A' && text[i] <= 'Z'))
        {
            l++;
        }
    }
    //float l = strlen(text) - spaces - sentences - special;
    float words = spaces + 1;//Needs to be 1 more as there is no space at the end of the sentence
    if (round(Index(sentences, words, l)) < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (round(Index(sentences, words, l)) > 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %.0f\n", round(Index(sentences, words, l)));
    }
}

//Function for finding the index of the sentences
float Index(float se, float w, float le)
{
    float L = (le / w) * 100;
    float S = (se / w) * 100;
    float index = 0.0588 * L - 0.296 * S - 15.8;
    return index;
}