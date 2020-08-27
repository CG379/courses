from cs50 import get_int
from sys import exit


def check(n, c):
    # Times every second number by 2
    for i in range(1, c, 2):
        n[i] = n[i] * 2
    total = 0
    temp = 0
    # Add the numbers together
    for i in range(c):
        temp = (n[i] // 10) + (n[i] % 10)
        total = total + temp
    # Retun true if it is divisible by 10
    if round(total) % 10 == 0:
        return True
    else:
        return False

# Ask for number with "do-while" loop


def main():
    while True:
        cardNumber = get_int("Number: ")
        if cardNumber > 0:
            break
    # Count the digits, while loop or len(str())?
    count = len(str(cardNumber))
    # If the card is valid
    if count != 13 and count != 15 and count != 16:
        print("INVALID")
        exit(0)
    number = list(map(int, str(cardNumber)))
    original = number.copy()
    number = list(reversed(number))
    v = check(n=number, c=count)
    # Visa test
    if (count == 13 or count == 16) and original[0] == 4 and v:
        print("VISA")
    # Amex test
    elif count == 15 and original[0] == 3 and v and (original[1] == 4 or 7):
        print("AMEX")
    # Mastercard test
    elif count == 16 and original[0] == 5 and v and original[1] in range(1, 5):
        print("MASTERCARD")
    else:
        print("INVALID")
    exit(0)


main()