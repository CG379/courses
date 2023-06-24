#Written for ECE2071 S1 2023
#Copyright Monash University 2023
# Purpose: A python test script for lab 3 of ECE2071
"""
HOW TO USE:
This file contains functions to test the code cracking and music analysis tasks.
The tester gets inputs from the command line, and should be used in the following way:

	python3 run_tests.py "code_cracking" "<input_filename>" "<program_output>" "<expected_output>" "<test_number>"
 or
	python3 run_tests.py "music_analysis" "<input_filename>" "<program_output>" "<expected_output>" "<test_number>"

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
def test_code_cracking():
	"""
	The first command line argument (sus.argv[1]) should be the exact string "code_cracking"
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
		print(f"Test {testNumber} passed! - Code cracking with input file {programInput}")
	else:
		print(f"Test {testNumber} failed! - Code cracking with input file {programInput}\n" + 
				f"\t Program Input:\n" + 
				f"\t\tFilename:\t{programInput}\n" + 
				f"\t\tContents:\t{read_file(programInput).strip()}\n" +
				f"\t Program Output:\t{programOutput}\n" + 
				f"\t Expected Output:\t{expectedOutput}\n")


def test_music_analysis():
	"""
	The first command line argument (sys.argv[1]) should be the exact string "music_analysis"
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
	programOutput = sorted(sys.argv[3].strip().split('\n'))  # sort to ignore the order of outputs
	expectedOutput = sorted(sys.argv[4].strip().split('\n'))  # sort to ignore the order of outputs
	testNumber = sys.argv[5]

	if programOutput == expectedOutput:
		print(f"Test {testNumber} passed! - Music Analysis with input file {programInput}")
	else:
		print(f"Test {testNumber} failed! - Music Analysis with input file {programInput}\n" + 
				f"\t Program Input:\n" + 
				f"\t\tFilename:\t{programInput}\n")
		print("\tDifferences in output:")
		for line in expectedOutput:
			if line not in programOutput:
				print(f"\t\tYour output missing: {line}")
		
		for line in programOutput:
			if line not in expectedOutput:
				print(f"\t\tYour output wrongly included: {line}")

if __name__ == "__main__":
	if len(sys.argv) < 2:
		print("Test name not provided")
		exit(0)
	programToTest = sys.argv[1]

	if programToTest == "code_cracking":
		test_code_cracking()
	elif programToTest == "music_analysis":
		test_music_analysis()
	else:
		print("Unknown program to test!")
  