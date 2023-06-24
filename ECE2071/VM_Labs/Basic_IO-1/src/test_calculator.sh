#!/bin/bash

#Written for ECE2071 S1 2023
#Copyright Monash University 2023

# compile the program:
cd src
make calculator

executableName="../outputs/calculator"

# Test 1: 320+184
programInput="320+184"
programOutput=$(echo $programInput | $executableName)  # gets the output of the program with the given input
expectedOutput="504"
python3 test_calculator.py "$programInput" "$programOutput" "$expectedOutput"  # calls the python test script

# Test 2: 85-43
programInput="85-43"
programOutput=$(echo $programInput | $executableName)
expectedOutput="42"
python3 test_calculator.py "$programInput" "$programOutput" "$expectedOutput"

# Test 3: 12*248832
programInput="12*248832"
programOutput=$(echo $programInput | $executableName)
expectedOutput="2985984"
python3 test_calculator.py "$programInput" "$programOutput" "$expectedOutput"

# Test 4: 20736 / 144
programInput="20736 / 144"
programOutput=$(echo $programInput | $executableName)
expectedOutput="144"
python3 test_calculator.py "$programInput" "$programOutput" "$expectedOutput"

# Test 5: 1047 % 10
programInput="1047%10"
programOutput=$(echo $programInput | $executableName)
expectedOutput="7"
python3 test_calculator.py "$programInput" "$programOutput" "$expectedOutput"