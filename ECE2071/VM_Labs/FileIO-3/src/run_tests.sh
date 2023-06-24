#!/bin/bash


# python "code_cracking" "<input_filename>" "<program_output>" "<expected_output>" "<test_number>"
cd ~/lab3/src


code="../outputs/code_cracking"
music="../outputs/music_analysis"
path1="../data/music_info.txt"
path2="../data/encrypted.txt"
path3="../data/encrypted2.txt"

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