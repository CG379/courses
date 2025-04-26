from sys import argv, exit
import csv
import re

if len(argv) != 3:
    print("Usage: python dna.py data.csv sequence.txt")
    exit(1)

# Open file and load it into memory


def File(argv):
    database = argv[1]
    sequence = argv[2]
    with open(database, 'r') as file:
        data = list(file.read().split())
    with open(sequence, 'r') as file2:
        sequence = file2.read()
    STR = data[0].split(",")
    STR.remove('name')
    Compare(data, Count(sequence, STR))
    exit(0)


# Counts the max cosecutive strs in the dna
def Count(sequence, STR):
    # Finds the positions of the STR in the string then checks if the difference between them is the length of the STR
    pattern = []
    for i in range(len(STR)):
        pos = [i.start() for i in re.finditer(STR[i], sequence)]
        # Records the position then check the spaces length between the position to see if the gap where the STR start match length of the str
        counter = 0
        strmax = 0
        for k in range(len(pos)):
            if pos[k] - pos[k-1] == len(STR[i]):
                counter += 1
                if counter > strmax:
                    strmax = counter
            else:
                counter = 0
        pattern.append(strmax + 1)
    return pattern

# Compare str count to find match


def Compare(data, pattern):
    # takes the str pattern from the csv and compares it to the one found in the txt file
    for i in range(1, len(data)):
        csvPattern = data[i].split(",")
        name = csvPattern[0]
        csvPattern.pop(0)
        if list(map(int, csvPattern)) == pattern:  # Need to convert the string list to an int list
            print(name)
            return True
    print("No match")
    return False


File(argv)