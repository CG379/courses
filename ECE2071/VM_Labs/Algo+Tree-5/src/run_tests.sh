#!/bin/bash


# python "code_cracking" "<input_filename>" "<program_output>" "<expected_output>" "<test_number>"
cd ~/lab3/src


simple_bubble="../outputs/simple_bubble_sort"
complex_bubble="../outputs/complex_bubble_sort"
array="../data/array.txt"
complex_array="../data/complex_array.txt"

programOutput1=$($music $path1) # gets the output of the program with the given input
programOutput2=$($code $path2)
programOutput3=$($code $path3)

# Expected outputs
output1="Everybody_Wants_To_Rule_The_World - Tears_For_Fears, Songs_From_The_Big_Chair (1985 - 989363525)\nYou_Get_What_You_Give - New_Radicals, Maybe_You've_Been_Brainwashed_Too (1998 - 336115780)\nTick_Tick_Boom - The_Hives, The_Black_and_White_Album (2007 - 81016902)\nWelcome_to_the_Machine - Pink_Floyd, Wish_You_Were_Here (1975 - 74901584)\nFuture_Starts_Slow - The_Kills, Blood_Pressures (2011 - 51912174)"
output2="6 3 42 5 548 72 57 1 12 9 78 0"
output3="1 2 3 4 8 12 16 15 14 13 9 5 6 7 11 10"

# Tests
python3 run_tests.py "code_cracking" "$path2" "$programOutput2" "$output2" "0" # calls the python test script
python3 run_tests.py "code_cracking" "$path3" "$programOutput3" "$output3" "1"
python3 run_tests.py "music_analysis" "music_info.txt" "$programOutpt" "$test" "2"


path="../outputs/component_database"
programInput="insert Resistor 120 K 20 1.2 print quit"
print="print"
quit="quit"
removalWord="Enter Command: "

test=$(echo "$programInput" | "$path")
test=$(echo $test | cut -d " " -f 7,8,9,10,11,12,13,14)

# python "run_tests.py" "component_database" "<input_filename>" "<program_output>" "<expected_output>"

python3 run_tests.py "component_database" "insert Resistor 120 K 20 1.2" "$test" "Component: Resistor 120 K, quantity: 20, price: 1.20" "3"
