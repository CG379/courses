import csv
from cs50 import SQL
from sys import exit, argv

# Splits the name into a list
def nameSplit(name):
    name = name.split()
    if len(name) == 2:
        name.insert(1, None)
    return name

if len(argv) != 2:
    print("Usage: python import.py csv")
    exit(1)

db = SQL("sqlite:///students.db")
# Open csv
with open(argv[1], 'r') as file:
    reader = csv.DictReader(file)

    for row in reader:
        # Ror each row, split the name
        name = nameSplit(row['name'])
        # Put each row into the table
        db.execute("INSERT INTO students (first, middle, last, house, birth) VALUES(?, ?, ?, ?, ?)", 
        name[0], name[1], name[2], row["house"], row["birth"])