from cs50 import get_int
"""
Program prints a pyramid with 2 spaces in the middle,
like the one in mario
"""
# Do-while loop for the user input
while True:
    size = get_int("Height: ")
    if size > 0 and size < 9:
        break

#
for i in range(size):
    # space
    for gap in range(size - i, 1, -1):
        print(" ", end="")
    # Left hashtags
    for blocksl in range(i + 1):
        print("#", end="")
    # Middle Gap
    print("  ", end="")
    # The right hashtags
    for blocksr in range(i + 1):
        print("#", end="")
    # New line for next set
    print()