from cs50 import get_string
from sys import exit
import re

# Spilts the string into individual letters and counts them

# Counts the number of words in the sentence

# Counts the number of sentences, anything the ends with "." "!" or "?"

# Index calculation: index = 0.0588 * L - 0.296 * S - 15.8

# L = Average number of letters per 100 words
# S = Average number of sentences per 100 words

# Calculates the index and returns the rounded value


def Index(se, w, le):
    L = (le / w) * 100
    S = (se / w) * 100
    index = (0.0588 * L) - (0.296 * S) - 15.8
    return round(index)


def Count(text):
    l = 0
    # Loops throung the text counting letters
    for i in range(len(text)):
        if text[i].isalpha():
            l += 1
    # Counts the occurance of sentence enders and the words in the string
    sentences = text.count(".") + text.count("?") + text.count("!")
    words = len(re.findall(r'\w+', text)) - text.count("'") - text.count("-")
    return Index(sentences, words, l)

# Gets the text and prints out the grade


def Main():
    text = get_string("Text: ")
    i = Count(text)
    if i > 16:
        print("Grade 16+")
    elif (i < 1):
        print("Before Grade 1")
    else:
        print("Grade " + str(i))


Main()