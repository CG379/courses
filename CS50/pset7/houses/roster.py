# TODO
from sys import argv, exit
from cs50 import SQL

# Check command line arguments
if argv[1].lower() != "gryffindor" and argv[1].lower() != "slytherin" and argv[1].lower() != "hufflepuff" and argv[1].lower() != "ravenclaw":
    print("Usage: python roster.py house")
    exit(1)
# Query database
db = SQL("sqlite:///students.db")

# Alphabetise
query = db.execute("SELECT first, middle, last, birth FROM students WHERE house = (?) ORDER BY last, first", argv[1])

    # Print the names
for row in query:
    if row['middle'] == None:
        print(row["first"] + " " + row["last"] + ", born " + str(row["birth"]))
    else:
        print(row["first"] + " " + row["middle"] + " " + row["last"] + ", born " + str(row["birth"]))


