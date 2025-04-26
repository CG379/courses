#Written for ECE2071 S1 2023
#Copyright Monash University 2023
# Purpose: A python test script for lab 4 of ECE2071
"""
HOW TO USE:
This file contains functions to test the Collatz and Component Database tasks.
The tester gets inputs from the command line, and should be used in the following way:

    python "collatz" "<input_filename>" "<program_output>" "<expected_output>" "<test_number>"
    
    or
    
    python "component_database" "<input_filename>" "<program_output>" "<expected_output>" "<test_number>"
    
It will print relevant information about the outcome of tests to the console. 
"""


import sys

def read_file(filename: str):
	with open(filename) as f:
		if f:
			contents = ''.join(l for l in f.readlines())
	if contents:
		return contents
	else:
		return "file could not be opened"

def test_collatz():
	"""
	The first command line argument (sys.argv[1]) should be the exact string "collatz"
	The second command line argument should be the name of the file used as inputs
	The third command line argument should be the output of your program
	The fourth command line argument should be the expected(correct) output of your program
    The fifth command line argument should be the number of the current test
	"""
	# get the command line inputs:
	if len(sys.argv) != 6:
		print("Incorrect number of command line arguments provided!")
		return
	
	programInput = sys.argv[2]
	programOutput = sys.argv[3].strip()  # remove trailing whitespaces
	expectedOutput = sys.argv[4].strip() # remove trailing whitespaces
	testNumber = sys.argv[5]

	if programOutput == expectedOutput:
		print(f"Test {testNumber} passed! - Collatz with input {programInput}")
	else:
		print(f"Test {testNumber} failed! - Collatz with input {programInput}\n" + 
				f"\t Program Input: {programInput}\n" + 
				f"\t Program Output:\t{programOutput}\n" + 
				f"\t Expected Output:\t{expectedOutput}\n")


def test_component_database():
    """
    The first command line argument (sys.argv[1]) should be the exact string "component_database"
    The second command line argument should be the name of the file used as inputs
    The third command line argument should be the output of your program
    The fourth command line argument should be the expected(correct) output of your program
    The fifth command line argument should be the number of the current test
    """
    # get the command line inputs:
    if len(sys.argv) != 6:
        print("Incorrect number of command line arguments provided!")
        return
    
    programInput = sys.argv[2]
    programOutput = sys.argv[3]
    expectedOutput = sys.argv[4]
    testNumber = sys.argv[5]

    if expectedOutput in programOutput:  # note the use of 'in' here instead of ==, why aren't we simply checking if expectedOutput == programOutput?
        print(f"Test {testNumber} passed! - Component Database")
    else:
        print(f"Test {testNumber} failed! - Component Database\n" + f"\t Program Input:")
        for line in programInput.split('\n'):
            print(f"\t\t{line}")

        output = programOutput.replace('Enter your command: ', '')
        print(f"\tYour program output:")
        for line in output.split('\n'):
            print(f"\t\t{line}")

        print(f"\tExpected output:")
        for line in expectedOutput.split('\n'):
            print(f"\t\t{line}")

if __name__ == "__main__":
	if len(sys.argv) < 2:
		print("Test name not provided")
		exit(0)
	programToTest = sys.argv[1]

	if programToTest == "collatz":
		test_collatz()
	elif programToTest == "component_database":
		test_component_database()
	else:
		print("Unknown program to test!")
  