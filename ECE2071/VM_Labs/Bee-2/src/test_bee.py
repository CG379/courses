import sys

def main():
    # get the input from the command line:
    if len(sys.argv) < 3:
        print("Not enough command line arguments given!")
        exit(0)
    programOutput = sys.argv[1]
    expectedOutput = sys.argv[2]

    # compare program output with expected output:
    if programOutput == expectedOutput:
        print(f"Test with input {programOutput} passed!")
    else:
        print(f"Program produced: {programOutput}.\nExpected: {expectedOutput}\n")

if __name__ == "__main__":
    main()