#!/bin/bash
cd src
make bee_count

executableName="../outputs/bee_count"

programOutput=$($executableName) # gets the output of the program with the given input
expectedOutput="There were 14 occurrences of the word bee in the text."
python3 test_bee.py "$programOutput" "$expectedOutput"