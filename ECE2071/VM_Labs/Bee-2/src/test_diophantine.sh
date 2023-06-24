#!/bin/bash

#Written for ECE2071 S1 2023
#Copyright Monash University 2023

# compile the program:
make diophantine

executableName="./diophantine"

# Test 1: 99
programInput="99"
programOutput=$(echo $programInput | $executableName)  # gets the output of the program with the given input
expectedOutput=""
python3 test_diophantine.py "$programInput" "$programOutput" "$expectedOutput"  # calls the python test script

# Test 2: 100
programInput="100"
programOutput=$(echo $programInput | $executableName)
expectedOutput="a=99 b=98 c=98"
python3 test_diophantine.py "$programInput" "$programOutput" "$expectedOutput"

# Test 3: 101
programInput="101"
programOutput=$(echo $programInput | $executableName)
expectedOutput="a=98 b=99 c=100
a=99 b=98 c=98
a=100 b=92 c=99
a=100 b=97 c=96"
python3 test_diophantine.py "$programInput" "$programOutput" "$expectedOutput"

# Test 4: 102
programInput="102"
programOutput=$(echo $programInput | $executableName)
expectedOutput="a=98 b=99 c=100
a=99 b=93 c=101
a=99 b=98 c=98
a=100 b=92 c=99
a=100 b=97 c=96
a=101 b=86 c=100
a=101 b=91 c=97
a=101 b=96 c=94
a=101 b=101 c=91"
python3 test_diophantine.py "$programInput" "$programOutput" "$expectedOutput"