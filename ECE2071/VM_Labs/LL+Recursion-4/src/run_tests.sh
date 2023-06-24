#!/bin/bash


cd ~/lab4/src
#make all


collatzInput1=35
collatzOutput1="35 106 53 160 80 40 20 10 5 16 8 4 2 1"
collatzOut1=$(../outputs/collatz 35)

collatzInput2=28
collatzOutput2="28 14 7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1"
collatzOut2=$(../outputs/collatz 28)

collatzInput3=800
collatzOutput3="800 400 200 100 50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1"
collatzOut3=$(../outputs/collatz 800)

# python "collatz" "<input_filename>" "<program_output>" "<expected_output>" "<test_number>"

componentInput1="insert Resistor 120 K 20 1.2"
componentInput2="print"
endTest="quit"
expectedOutput="Component: insert Resistor 120 K 20 1.2"


python3 run_tests.py "collatz" "$collatzInput1" "$collatzOut1" "$collatzOutput1" "0"
python3 run_tests.py "collatz" "$collatzInput2" "$collatzOut2" "$collatzOutput2" "1"
python3 run_tests.py "collatz" "$collatzInput3" "$collatzOut3" "$collatzOutput3" "2"


# https://linuxdigest.com/howto/using-the-cut-command-in-bash/
path="../outputs/component_database"
programInput="insert Resistor 120 K 20 1.2 print quit"
print="print"
quit="quit"
removalWord="Enter Command: "

test=$(echo "$programInput" | "$path")
test=$(echo $test | cut -d " " -f 7,8,9,10,11,12,13,14)

# python "run_tests.py" "component_database" "<input_filename>" "<program_output>" "<expected_output>"

python3 run_tests.py "component_database" "insert Resistor 120 K 20 1.2" "$test" "Component: Resistor 120 K, quantity: 20, price: 1.20" "3"


