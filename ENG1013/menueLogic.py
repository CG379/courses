import time

settings = [0.02, [20,30,30]]

def Settings(type):
    while True:
        try: 
            print("- "* 10 +  "Change Setting" + "- "* 10)
            # option for changing the 
            if type == 2:
                print(f"Below {settings[0][0]}C is cold, change to : ")
                settings[1][0] = int(input())
                print(f"Upperbound for normal temp is {settings[0][1]}C, change to : ")
                settings[1][1] = int(input())
                print(f"Above {settings[0][2]}C is hot, change to : ")
                settings[1][2] = int(input())
            elif type == 1:
                print(f"Change Loop Speed from {settings[1]} to : ")
                settings[0] = float(input())
            break
        except:
            print("Invalid Input, Try again")
        print("\033c")
        displayMain()



def displayMain():
    # Option to return to polling loop
    # Fan speeds
    # Anything defined as a constant
    print() 
    print("- "* 10 +  "Main Menue" + "- "* 10)
    print("1. Variable Check Rate")
    print("2. Fan Calibration") # What is cold, warm and hot
    print("0. Exit")
    print("- "* 10 + "- "* 5 + "- "* 10)
    option = -1
    while True:
        try:
            option = int(input())
            if option == 0 or 1 or 2:
                break
            else:
                print("Invalid Option, Try again")
        except:
            print("Invalid Option, Try again")
    if option == 0:
        return
    Settings(option)
    print("\033c")
    return

def display():
    pin = "1234"
    attempts = 5
    i = 0
    while i < attempts:
        user = input("Input pin to access settings: ")
        i += 1
        if user == pin:
            print("\033c")
            displayMain()
            break
        else:
            print("Invald input, Try again")
    if i == attempts:
        return 5
    else:
        return 0



# Keyboard interupt to the menue within the main loop
# Except keyBoardinterupt
def main():
    timeOut = 0
    while True:
            try:
                # Arduino stuff
                a = 0
            except KeyboardInterrupt and (time.time() > timeOut):
                print()
                if check.lower() == "y" and (time.time() > timeOut):
                    lockOut = display()
                    timeOut = time.time() + lockOut
                    main()
                else:
                    # Other functions
main()