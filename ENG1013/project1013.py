#import modules
from pymata4 import pymata4
import time
import matplotlib.pyplot as plt
import math

#setup board
arduino = pymata4.Pymata4()

# Buzzer sounds
sounds = {"rapidUp" : [[100, 100, 30], [50, 100, 30], [10, 100, 30]],
        "rapidDown" : [[100, 100, 50]],
        "Music":[(818, 600, 50),(954, 600, 50),(540, 400, 50),
(954, 600, 50),(1106, 600, 50),(1371, 100, 25),(1189, 100, 25),
(1106, 100, 25),(818, 100, 25),(818, 600, 50),(954, 600, 50),
(540, 1000, 50),(125, 100, 25),(125, 100, 25),(540, 100, 25),
(449, 100, 25),(408, 100, 25),(264, 100, 25),(264, 600, 50),(332, 600, 50),
(125, 400, 50),(332, 600, 50),(408, 600, 50),(540, 100, 25),(449, 100, 25),
(408, 100, 25),(264, 100, 25),(264, 600, 50),(332, 600, 50),(125, 1000, 50),
(21, 100, 25),(21, 100, 300),(21, 100, 25),(21, 100, 300),

(125, 100, 25),(176, 100, 25),(264, 100, 25),(176, 100, 25),(408, 400, 25),
(408, 400, 25),(332, 600, 25),(125, 100, 25),(176, 100, 25),(264, 100, 25),
(176, 100, 25),(332, 400, 25),(332, 400, 25),(264, 400, 25),(233, 100, 25),
(176, 225, 25),(125, 100, 25),(176, 100, 25),(264, 100, 25),
(176, 100, 25),(264, 325, 75),(332, 225, 25),(233, 100, 25),(176, 225, 25),
(125, 600, 25),(125, 225, 25),(332, 500, 25),(264, 1000, 25),
(125, 100, 25),(176, 100, 25),(264, 100, 25),(125, 100, 25),(408, 400, 25),
(408, 400, 25),(332, 600, 25),(125, 100, 25),(176, 100, 25),(264, 100, 25),
(176, 100, 25),(540, 400, 25),(233, 225, 25),(264, 325, 25),(233, 100, 25),
(176, 400, 25),(125, 100, 25),(176, 100, 25),(264, 100, 25),
(125, 100, 25),(264, 400, 25),(332, 225, 25),(233, 400, 25),(176, 100, 25),
(125, 600, 25),(125, 225, 25),(332, 500, 25),(264, 1000, 25)]
}

# Codes for 7 seg
numbers = [
        0b11111100,  # = 0
        0b01100000,  # = 1
        0b11011010,  # = 2
        0b11110010,  # = 3
        0b01100110,  # = 4
        0b10110110,  # = 5
        0b10111110,  # = 6
        0b11100000,  # = 7
        0b11111110,  # = 8
        0b11110110,  # = 9
        0b00000000   # = None
]
letters = { "A": 0b11101110,
            "b": 0b00111110,
            "C": 0b10011100,
            "d": 0b01111010,
            "E": 0b10011110,
            "F": 0b10001110,
            "G": 0b11110110,
            "h": 0b00101110,
            "I": 0b00001100,
            "J": 0b01110000,
            "m": [0b00101010,0b00101010],
            "L": 0b00011100,
            "n": 0b00101010,
            "o": 0b00111010,
            "P": 0b11001110,
            "q": 0b11100110,
            "r": 0b00010010,
            "S": 0b10110110,
            "t": 0b00011110,
            "u": 0b01111100,
            "v": 0b00111000,
            "w": [0b00111000,0b00111000],
            "X": 0b01101110,
            "y": 0b01110110,
            "Z": 0b11011010,
            "DEG": 0b11000110,
            "0": 0b11111100,
            "1": 0b01100000,
            "2": 0b11011010,
            "3": 0b11110010,
            "4": 0b01100110,
            "5": 0b10110110,
            "6": 0b10111110,
            "7": 0b11100000,
            "8": 0b11111110,
            "9": 0b11110110,
            None: 0b00000000
}
DEC = 0b00000001
codes = ["RED", "YELO", "GREN", "FULL", "EMPT", "HOT", "COLD"]


# Pin setup
buzzerPin = 6
dataPin = 10 # SER
latchPin = 9 # RCLK
clockPin = 8 # SRCLK
ShiftRegPins = [dataPin, latchPin, clockPin]
settings = [0.02, [20,30,30]]

D1 = 2
D2 = 3
D3 = 4
D4 = 5
digit = [D1, D2, D3, D4]

arduino.set_pin_mode_analog_input(0)

#list beginning, keeps it at 60 length
list=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

for i in range(len(digit)):
    arduino.set_pin_mode_digital_output(digit[i])

arduino.set_pin_mode_digital_output(dataPin)
arduino.set_pin_mode_digital_output(latchPin)
arduino.set_pin_mode_digital_output(clockPin)

pinLayout = [dataPin, clockPin, D1, D2, D3, D4, latchPin]

# Define Temperaatures
internalTemperature = [20]
externalTemp = [9]


#R2.1.1 Heat states low, normal, high DONE
cold = "cold"
normal = "normal"
hot = "hot"


# set pin modes
arduino.set_pin_mode_pwm_output(3)
arduino.set_pin_mode_pwm_output(5)
arduino.set_pin_mode_digital_output(4)

arduino.set_pin_mode_pwm_output(buzzerPin)


def steralise_num(num):
    # Identify decimal place
    num = str(num)
    DP = [0]*4
    tempDP = num.find('.')
    if tempDP == -1:
        # Number has no DP
        pass
    else:
        DP[tempDP - 1] = DEC
        # Split into digits
        num = list(map(str, num))
        num.remove(".")
    num = list(map(int, num))
    # Make sure list is length 4
    while len(num) < 4:
        num = num + [10]
    # digit list, Dec place
    return num, DP


def steralise_alpha(word, segCodes):
    word = list(word)
    output = [0] * 4
    # Find code in list
    for i in range(len(word)):
        if (word[i].upper() in segCodes.keys()):
            output[i] = segCodes[word[i].upper()]
        elif (word[i].lower() in segCodes.keys()):
            output[i] = segCodes[word[i].lower()]
    # Make sure list is length 4
    while len(word) < 4:
        word = word + [segCodes[None]]


def write_to_7_seg_series(segCode,ardBoard,pins,pinMask,ID):
    for i in range(8):
        if (segCode) & (pinMask << i):
            ardBoard.digital_write(pins[0],1)
        else:
            ardBoard.digital_write(pins[0],0)
        #clock handling:
        #setup
        ardBoard.digital_write(pins[1],1)
        #hold
        ardBoard.digital_write(pins[1],0)
    
    #enable output
    ardBoard.digital_write(pins[6],1)
    ardBoard.digital_write(ID,0)
    time.sleep(200e-6)
    #disable output
    ardBoard.digital_write(ID,1)
    ardBoard.digital_write(pins[6],0)


def write_to_4_digits_serial(segCodes,ardBoard,pins,n):
    
    pinMask = 0b00000001
    #force all digits off prior to draw
    ardBoard.digital_write(pins[2],1)
    ardBoard.digital_write(pins[3],1)
    ardBoard.digital_write(pins[4],1)
    ardBoard.digital_write(pins[5],1)
    #preset clock position clock
    ardBoard.digital_write(pins[1],0)
    ardBoard.digital_write(pins[6],0)
    #iterate and draw
    # Clean up input
    if isinstance(n, (int, float)):
        n, DP = steralise_num(n)
    elif isinstance(n, str):
        n = steralise_alpha(n, segCodes)
        PD = [0] * 4
    else:
        return -1
    # Write to specific digit
        #digit 0:
    write_to_7_seg_series(segCodes[n[3]] + DP[3],ardBoard,pins,pinMask,pins[2])
        #digit 1: 
    write_to_7_seg_series(segCodes[n[2]] + DP[2],ardBoard,pins,pinMask,pins[3])
        #digit 2
    write_to_7_seg_series(segCodes[n[1]] + DP[1],ardBoard,pins,pinMask,pins[4])
        #digit 3:
    write_to_7_seg_series(segCodes[n[0]] + DP[0],ardBoard,pins,pinMask,pins[5])

def display_7_Seg(input):
    write_to_4_digits_serial(numbers,arduino,pinLayout,input)


#Frequency, length note is played in ms, length of pause after ms
def playNote(note, noteDuration, delayDuration, myBoard, buzzerPin):
    myBoard.pwm_write(buzzerPin, note)
    time.sleep(noteDuration/(10**3))
    myBoard.pwm_write(buzzerPin, 0)
    time.sleep(delayDuration/(10**3))

# Play the sound with the specified board and puzzer pin
def buzz(board, buzzerPin, sound):
    for note in sound:
        playNote(note[0], note[1], note[2], board, buzzerPin)


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


def readTemp():
    #read the raw analog data every second.
    time.sleep(1)
    value = arduino.analog_read(0)[0]

    #Convert Analog Reading to Voltage
    voltage = value * (5/1023)

    #Find restistance of thermistor
    resistance = (5100/(voltage-1))
    thermBeta = 4314
    inverseTemperature = (1/298.15) + ((1/4314)*math.log(resistance/10000))
    temperature = 1/inverseTemperature

    #5 degree offset to better match room temp, needs debugging
    valueTemp = (temperature-273-5)

    # maintains list of length 60 for past 60 seconds
    list.append(valueTemp)
    if len(list) > 60:
        list.pop(0)
    print(f"Temperature is: {int(valueTemp)} degrees")


def motor():
    # Arduino stuff
    if internalTemperature[-1] <= settings[0]:
        tempState = cold
    elif internalTemperature[-1] <= settings[1]:
        tempState = normal
    elif internalTemperature[-1] > settings[2]:
        tempState = hot
    print(tempState)

    #The fan operation for these heat states is written below, as G2.2.1 satisfies all the below modules
    # G2.1.4 (2+ speed from difference to room set point)
    # G2.1.5 (5+ precise motor speeds from difference to set point)

    #G2.2.1 Speed based on temperature difference from external temp
    # the below code takes the temperature of two different thermistors, and attemps to equalise them.
    #ie. if the outside temp is warmer it will warm up the room
    #ie. if the outside temp is cooler it will cool the room
    #ie. A manual deisred temperature can be achieved by changing the externalTemp list.

    tempGradient = internalTemperature[-1]-externalTemp[-1]
    print(f'Temp Gradient is {tempGradient}')


    #determine if spin left or right
    #spin left = blow in (remove hot air) , spin right = blow out (bring hot air in)

    #enable motors


    #if temp gradient is <10 degrees the fan runs at 100%
    if tempGradient < -10:
        arduino.digital_pin_write(4, 1)
        pwmValue = 0 #full speed in spin right
        arduino.pwm_write(3,0)
        arduino.pwm_write(5,255)
        fanSpeed = abs((pwmValue-255)/255)*100
        print(f'Fan Speed is {fanSpeed}% , (PWM value = {pwmValue})')

    #if temp gradient is >10 degrees fan runs 100%
    elif tempGradient > 10:
        arduino.digital_pin_write(4, 1)
        pwmValue = 0 #full speed spin left
        fanSpeed = abs((pwmValue-255)/255)*100
        print(f'Fan Speed is {fanSpeed}% , (PWM value = {pwmValue})')
        arduino.pwm_write(3, 255)
        arduino.pwm_write(5,0)    

    #if temp gradient is between -10 and 0, the fan speed changes in a continious range.
    elif tempGradient < 0: 
        arduino.digital_pin_write(4, 1)
        pwmValue = (tempGradient/10) * 255
        pwmValue = int(pwmValue)
        pwmValue = abs(pwmValue)
        fanSpeed = abs((pwmValue-255)/255)*100
        print(f'Fan Speed is {fanSpeed}% , (PWM value = {pwmValue})')
        arduino.pwm_write(3, pwmValue)
        arduino.pwm_write(5, 255)
            #temp is below ambient, spin air into room right

    #if temp gradient is between 0 and 10 the fan speed changes in continous range
    elif tempGradient > 0:
        arduino.digital_pin_write(4, 1)
        pwmValue = (tempGradient/10) * 255 - 255
        abs(pwmValue)
        pwmValue = int(pwmValue)
        pwmValue = abs(pwmValue)
        fanSpeed = abs((pwmValue-255)/255)*100
        print(f'Fan Speed is {fanSpeed}% , (PWM value = {pwmValue})')
        arduino.pwm_write(3,255)
        arduino.pwm_write(5, pwmValue)
        #spin left
            #temp is above ambient, spin air out of room left
    elif tempGradient == 0:
        #disable motors by cutting off enable pin = 0
        arduino.digital_pin_write[4, 0]
#notes:
#note that if a pwm is set to 255 the output is no voltage,
#if pwm is set to 0 then the voltage is high
#this means a pwm of 0 = 100%, and 255 = 0% motor speed.
#pin 4 low = motor off, pin 4 high = motors enable

#note: the fan speed does not seem to be the highest possible, i believe this
# is due to resistance losses/poor connections with so many wires
# jiggling around wires seems to adjust the speed sometimes suggesting this :)

# Main function
def main():
    timeOut = 0
    while True:
            try:
                # TODO: Put it all together
                # Recieve 555 signal
                # Check for safety inputs 
                # Check for ultrasonic sensor output
                # Do motor stuff based on inputs
                # Write values to 7 seg
                #Send 555 signal
                # Make Blue LED blink

            except KeyboardInterrupt:
                playNote(0, 0, 0, arduino, buzzerPin)
                print()
                check = input("Do you want to change the settings? (Y/N) ")
                if check.lower() == "y" and (time.time() > timeOut):
                    lockOut = display()
                    timeOut = time.time() + lockOut
                    main()
                else:
                    list.reverse()
                    print(list)
                    #Set Graph current time
                    currentTime = time.strftime("%Y-%m-%d at %H %M %S")
                    str(currentTime)

                    #Plot points of the Graph
                    ypoints = list
                    xpoints = [60,59,58,57,56,55,54,53,52,51,50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,
                    33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1]
                    plt.plot(xpoints, ypoints,)
                    plt.title(f"System Temperature in last 60 Seconds \n (Generated {currentTime})")
                    plt.ylabel("Temperature (Celsius)")
                    plt.xlabel("Past 60 Seconds (sec) \n (where 60 is most recent)")
                    plt.savefig("System Temperature Graph " + currentTime + ".jpg")
                    print("Saving Graph")
                    time.sleep(0.5)
                    plt.show()
main()
