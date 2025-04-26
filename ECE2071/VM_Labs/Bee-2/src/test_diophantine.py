#Written for ECE2071 S1 2023
#Copyright Monash University 2023

import sys

def main():
    # get the input from the command line:
    if len(sys.argv) < 4:
        print("Not enough command line arguments given!")
        exit(0)
    programInput = sys.argv[1]
    programOutput = sorted(sys.argv[2].split("\n"))  # sorting allows us to ignore the order of the output
    expectedOutput = sorted(sys.argv[3].split("\n"))

    # compare program output with expected output:
    if programOutput == expectedOutput:
        print(f"Test with input {programInput} passed!")
    else:
        print(f"Program produced {sys.argv[2]} for input {programInput}. Expected {sys.argv[3]}")

if __name__ == "__main__":
    main()