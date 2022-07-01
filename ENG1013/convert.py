
# Convert between temp units K, C, F, R, D
def convertTemp():
    measurement = input("Please input a measurement: (K, C, F, R, D)")
    value = input("Input your value")
    if value.isnumeric():
        print("Invalid")
        return
    value = float(value)
    if measurement.lower() == "k":
        print(f"{value} K")
        print(f"{value - 237} C")
        print(f"{(value * 1.8) - 459.67} F")
        print(f"{(value * 1.8)} R")
        print(f"{(373.15 - value) * 1.5} R")
    elif measurement.lower() == "c":
        kelvin = value + 237
        print(f"{value} C")
        print(f"{kelvin} K")
        print(f"{(kelvin * 1.8) - 459.67} F")
        print(f"{(kelvin * 1.8)} R")
        print(f"{(373.15 - kelvin) * 1.5} R")
    elif measurement.lower() == "f":
        kelvin = (value + 459.67) * (5/9)
        print(f"{value} F")
        print(f"{kelvin - 237} C")
        print(f"{kelvin} K")
        print(f"{(kelvin * 1.8) - 459.67} F")
        print(f"{(kelvin * 1.8)} R")
        print(f"{(373.15 - kelvin) * 1.5} R")
    elif measurement.lower() == "r":
        kelvin = value / 1.8
        print(f"{value} R")
        print(f"{kelvin - 237} C")
        print(f"{kelvin} K")
        print(f"{(kelvin * 1.8) - 459.67} F")
        print(f"{(kelvin * 1.8)} R")
        print(f"{(373.15 - kelvin) * 1.5} D")
    elif measurement.lower() == "d":
        kelvin = 373.15 - (value * (2/3))
        print(f"{value} D")
        print(f"{kelvin - 237} C")
        print(f"{kelvin} K")
        print(f"{(kelvin * 1.8) - 459.67} F")
        print(f"{(kelvin * 1.8)} R")
        print(f"{(373.15 - kelvin) * 1.5} R")
    else:
        print("Invalid")
    return


def convert():
    user = input("What do u wnt to convert between:\n (Temp or Length)")
    if user.lower() == "temp":
        convertTemp()
    else:
        print("Invalid")
    return
    '''
    elif user.lower() == "length":
        convertLength()
        '''
    
