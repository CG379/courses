import math

def triangle():
    # Assume the user writes the side lengths in order
    a1 = input("Input side: ")
    b1 = input("Input side: ")
    c1 = input("Input side: ")

    if a1 != "" and b1 != "" and c1 == "":
        print("finding side C")
        sideC = math.sqrt(float(a1)**2 + float(b1)**2)
        print(sideC)

    elif b1 != "" and c1 != "" and a1 == "":
        print("For side A")
        sideA = math.sqrt(float(c1)**2 - float(b1)**2)
        print(sideA)

    elif sideC != "" and sideA != "" and sideB == "":
        print("for side B")
        sideB = math.sqrt(float(c1)**2 - float(a1)**2)
        print(sideB)

    else:
        print("Invalid")
    return



def tax():
    income = float(input("What is your income (no symbols): "))
    taxableIncome = [0,18200,45000,120000,180000]
    taxIncome = [0, 0.19, 0.325, 0.37, 0.45]
    addative =[0,0,5092,29467,51667]
    tax = 0

    for i in range(len(taxableIncome)):
        if income <= i:
            tax += (income - taxableIncome[i]) * taxIncome[i] + addative[i]
    print(tax) 

'''
def speeding():
    weight = float(input("Vehicle weight in tonnes: "))
    limit = int(input("Speed limit of the area in km/h: "))
    speed = float(input("Vehicle speed in km/h: "))
    overLimit = math.floor(speed - limit)
    if weight < 4.5:
        if overLimit < 10:
            penalty = 227
            demerit = 1
    else: 
        if overLimit < 10:
            penalty = 318
            demerit = 1
'''

def inputs():
    user = int(input("Enter list length: "))
    values = [0] * user
    print("Input n to exit")
    while True:
        value = input("Input value: ")
        if value == "n":
            return values
        elif value.isnumeric():
            values.pop()
            values.insert(0, float(value))
            print(values)
        else:
            print("invalid")
    
#print(inputs())

def fin_min(n):
    '''
    lo = n[0]
    for element in n:
        if element <= lo:
            lo = element
    return lo
    '''
    return min(n)

def find_max(n):
    '''
    hi = n[0]
    for element in n:
        if element >= hi:
            hi = element
    return hi
    '''    
    return max(n)

def multiTable():
    number = input("What times table do u want? (no decimals)\n")
    while number.isnumeric() == False:
        number = input("Invalid, try again: ")
    number = int(number)
    for i in range(1,13):
        result = i * number
        print(f"{i} * {number} = {result}")
multiTable()


