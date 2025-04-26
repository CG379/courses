#import modules

from pymata4 import pymata4
import time
import matplotlib.pyplot as plt
import math


# ALL VARIABLES
myBoard = pymata4.Pymata4()




# PINS DEFINED # 

#7seg pins#
D1 = 0      
D2 = 1
D3 = 2
D4 = 3
digit = [D1, D2, D3, D4]
dataPin = 4 # SER
latchPin = 5 # RCLK
clockPin = 6 # SRCLK

# 555 timer pins ###
arduinoresetsignal = 7
timerresetsignal = 11
#Ultrasonic Sensor Pins#
triggerPin = 12
echoPin = 13
# motor pins# 
motorEnable = 8
motor1 = 9
motor2 = 10

#analog pins#
thermistorPin1 = 0
thermistorPin2 = 1
safetyLightPin = 17 ############## fix now ######## (analog 3)
buzzerPin = 18 # digital analog (4)
analogButtonPin = 5
LDRPin = 2


distanceCm = 2
store = [0]
ultrasonicSensorList = [0]
pinCode = "0000"


#define the pins to be used


# MENU STUFF #
# Low, medium, high?
heatState = "lo"
# Seconds
checkRate = 0.02
# pwm Multiplier for analog buttons

pwmMultiplier = 1
settings = [pinCode, checkRate, pwmMultiplier]

internalTempList=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
externalTempList=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

currentTime = time.strftime("%Y-%m-%d at %H %M %S")
str(currentTime)


############ BUZZER CONSTANTS ############### #######################################################################################
sounds = {"rapidUp" : [[100, 100, 30], [50, 100, 30], [10, 100, 30]],
        "rapidDown" : [[100, 100, 50]]
}

threshold = 5

################# ANALOG BUTTON CONSTANTS ################################################################

downButton = range(508, 509)
upButton = 1023

########################## 7 SEG DISPLAY CONSTANTS ###########################
# Numbers from 0-9 in binary, represented as ABCDEFG(DEC) on the display
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
            #"m": [0b00101010,0b00101010],
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
            #"w": [0b00111000,0b00111000],
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

LED = [0b00000001, 0b00000011, 0b00000111, 0b00001111, 0b00011111]



codes = ["RED", "YELO", "GREN", "FULL", "EMPT", "HOT", "COLD"]

delayTime = 5 # in s

ShiftRegPins = [dataPin, latchPin, clockPin]

pinLayout = [dataPin, clockPin, D1, D2, D3, D4, latchPin]


tempCounter = 0



cold = "cold"
normal = "normal"
hot = "hot"







##################### PIN MODES ##################

myBoard.set_pin_mode_digital_output(digit[0])
myBoard.set_pin_mode_digital_output(digit[1])
myBoard.set_pin_mode_digital_output(digit[2])
myBoard.set_pin_mode_digital_output(digit[3])


#for i in range(len(digit)):
    #myBoard.set_pin_mode_digital_output(digit[i])

myBoard.set_pin_mode_digital_output(dataPin)
myBoard.set_pin_mode_digital_output(latchPin)
myBoard.set_pin_mode_digital_output(clockPin)
myBoard.set_pin_mode_pwm_output(safetyLightPin)
myBoard.set_pin_mode_pwm_output(buzzerPin)



myBoard.set_pin_mode_digital_output(timerresetsignal)
myBoard.set_pin_mode_digital_input(arduinoresetsignal)

######## old start of loop the pins and set pins mode stuff need to go up top, move sonar_setup to just after that #

myBoard.set_pin_mode_pwm_output(motor1)
myBoard.set_pin_mode_pwm_output(motor2)
myBoard.set_pin_mode_digital_output(motorEnable)

myBoard.set_pin_mode_analog_input(thermistorPin1)
myBoard.set_pin_mode_analog_input(thermistorPin1)
myBoard.set_pin_mode_analog_input(thermistorPin2)

myBoard.set_pin_mode_analog_input(analogButtonPin) 
checkRate = 0.1





def sonar_callback(data):
    store[0] = data[2]


def sonar_setup(myBoard, triggerPin, echoPin):
    myBoard.set_pin_mode_sonar(triggerPin, echoPin, sonar_callback, timeout=200000)
    time.sleep(0.1)


sonar_setup(myBoard, triggerPin = triggerPin , echoPin = echoPin)




# Frequency, length note is played in ms, length of pause after ms
def playNote(note, noteDuration, delayDuration, myBoard, buzzerPin):
    myBoard.pwm_write(buzzerPin, note)
    time.sleep(noteDuration/(10**3))
    myBoard.pwm_write(buzzerPin, 0)
    time.sleep(delayDuration/(10**3))

# Play the sound with the specified board and puzzer pin
def buzz(myBoard, buzzerPin, sound):
    for note in sound:
        playNote(note[0], note[1], note[2], myBoard, buzzerPin)


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

def display_7_Seg(input):
    write_to_4_digits_serial(numbers,myBoard,pinLayout,delayTime,input)

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


def write_to_7_seg_series(segCode,myBoard,pins,pinMask,ID):
    #TODO this function needs to take an individual segCode (for a segment)
    # and write it to a single digit, using the shift register.
    for i in range(8):
        #TODO compare this to the code from week 5, why do we use << not >>?
        if (segCode) & (pinMask << i):
            myBoard.digital_write(pins[0],1)
        else:
            myBoard.digital_write(pins[0],0)
        #clock handling:
        #setup
        myBoard.digital_write(pins[1],1)
        #hold
        myBoard.digital_write(pins[1],0)
    
    #enable output
    myBoard.digital_write(pins[6],1)
    if ID == -1:
        pass
    else:
        myBoard.digital_write(ID,0)
        time.sleep(200e-6)
        #disable output
        myBoard.digital_write(ID,1)
    myBoard.digital_write(pins[6],0)

    

def write_to_4_digits_serial(segCodes,myBoard,pins,wait,n):
    
    pinMask = 0b00000001
    #force all digits off prior to draw
    myBoard.digital_write(pins[2],1)
    myBoard.digital_write(pins[3],1)
    myBoard.digital_write(pins[4],1)
    myBoard.digital_write(pins[5],1)
    #preset clock position clock
    myBoard.digital_write(pins[1],0)
    myBoard.digital_write(pins[6],0)
    #iterate and draw
    # LED thermometer 
    if n > 23 and n <= 27:
        LEDThermo = LED[2]
    elif n > 27 and n < 30:
        LEDThermo = LED[3]
    elif n >= 30:
        LEDThermo = LED[4]
    elif n > 20 and n <= 23:
        LEDThermo = LED[1]
    elif n <= 16:
        LEDThermo = LED[0]
    else:
        LEDThermo = 0
    
    # Clean up input
    try: 
        n, DP = steralise_num(n)
    except:
        try:
            n = steralise_alpha(n, segCodes)                                                 ########## changed from PD to DP. let me know if change back campbell
            DP = [0] * 4
        except:
            n = [segCodes["E"], segCodes["r"], segCodes["o"], segCodes["r"]]
            DP = [0] * 4
    # Write to specific digit
    write_to_7_seg_series(LEDThermo,myBoard,pins,pinMask,-1)
    #digit 0:
    write_to_7_seg_series(segCodes[n[3]] + DP[3],myBoard,pins,pinMask,pins[2])
    
    write_to_7_seg_series(LEDThermo,myBoard,pins,pinMask,-1)
    #digit 1: 
    write_to_7_seg_series(segCodes[n[2]] + DP[2],myBoard,pins,pinMask,pins[3])
    
    write_to_7_seg_series(LEDThermo,myBoard,pins,pinMask,-1)
    #digit 2
    write_to_7_seg_series(segCodes[n[1]] + DP[1],myBoard,pins,pinMask,pins[4])
    
    write_to_7_seg_series(LEDThermo,myBoard,pins,pinMask,-1)
    #digit 3:
    write_to_7_seg_series(segCodes[n[0]] + DP[0],myBoard,pins,pinMask,pins[5])



def sonar_report():
    pass
    y = store[0]
    return y



def Settings(type):
    while True:
        try:
            print("- "* 10 +  "Change Setting" + "- "* 10)
            if type == 1:
                print(f"Change PIN code from {settings[0]} to :")
                settings[0] = str(input())
            elif type == 2:
                print(f"Change Loop Speed from {settings[1]} to :")
                settings[1] = float(input())
            elif type == 3:
                print(f"Change PWM Multiplier from {settings[2]} to :")

                settings[2] = float(input())
            elif type == 4:
                    ################## GRAPH 1 ################
                ypoints = internalTempList
                xpoints = [60,59,58,57,56,55,54,53,52,51,50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1]
                plt.plot(xpoints, ypoints,)
                plt.title(f"System Internal Temperature in last 60 Seconds \n (Generated {currentTime})")
                plt.ylabel("Temperature (Celsius)")
                plt.xlabel("Past 60 Seconds (sec) \n (where 60 is most recent)")

                #Print and show graph
                plt.savefig(f"System Internal Temperature Graph " + currentTime + ".jpg")
                print("Saving Graph 1 ")

        ####################### GRAPH 2 ##############
                ypoints = externalTempList
                xpoints = [60,59,58,57,56,55,54,53,52,51,50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1]
                plt.plot(xpoints, ypoints,)
                plt.title(f"System External Temperature in last 60 Seconds \n (Generated {currentTime})")
                plt.ylabel("Temperature (Celsius)")
                plt.xlabel("Past 60 Seconds (sec) \n (where 60 is most recent)")

                #Print and show graph
                plt.savefig(f"System External Temperature Graph " + currentTime + ".jpg")
                print("Saving Graph 2")
                time.sleep(1)
            else:
                break
            break
   
                    
        except:
            print("Invalid Input, Try again")
    
        print("\033c")
        displayMain()



def displayMain():
    timeoutCounter = 0
    try:
        while True:
            codeDetect = input("Input PIN code: ")
            if codeDetect == settings[0]:
                
                # Option to return to polling loop
                # Fan speeds
                # Anything defined as a constant
                print() 
                print("- "* 10 +  "Main Menu" + "- "* 10)
                print("1. Change PIN Code")
                print("2. Variable Check Rate")
                print("3. Change Motor Button Multiplier ") # how fast the fans ramp up and down on button press
                print("4. Save Graphs")
                print("0. Exit")
                print("- "* 10 + "- "* 5 + "- "* 10)
                option = -1
                while True:
                    try:
                        option = int(input())
                        if option == 0 or 1 or 2 or 3 or 4:
                            break
                        else:
                            print("Invalid Option, Try again")
                    except:
                        print("Invalid Option, Try again")
                Settings(option)
                print("\033c")
                return
            elif (codeDetect != settings[0]) and (timeoutCounter > 3):
                print("Too many Invalid PIN Codes, Timeout") 
                time.sleep(1)    
            elif codeDetect != settings[0]:
                print("Invalid PIN code, Please try again")
                timeoutCounter = timeoutCounter + 1 
    except KeyboardInterrupt:
        print("Invalid Pin Code, Please Try Again")
        timeoutCounter = timeoutCounter + 1 
            




# Keyboard interupt to the menue within the main loop
# Except keyBoardinterupt



def main():
    print("Running main code")
    pwmMultiplier = 1
    tempCounter = 0
    tempGradient = tempGradient
    fanSpeed = fanSpeed
    pwmValue = pwmValue
    # not sure how to fix this part?, it doesnt read the global value from the  top of code.
    while True:



        try:
            
            while True:
                inputvalue = myBoard.digital_read(arduinoresetsignal)[0]
                # Resets code if heartbeat not detected from 555 timer.
                if inputvalue == 1:
                    print("arduino reset")
                    myBoard.send_reset()       
                    time.sleep(2)
                    continue
                ################### 555 TIMER PART ###########
                #start the timer at the beginning of the code by setting the digital output pin to 0V
                myBoard.digital_write(timerresetsignal, 0)

                #myBoard.digital_write(timerresetsignal, 1)
                #uncomment the line above to test the reset system


                #read for the input value from the timer
                inputvalue = myBoard.digital_read(7)[0]


                #the digital output pin is set back to 5V at the end of the code, so that the signal pulses once it restarts the loop
                #(comment this code below to test reset)
               
            


                ##################### THERMISTOR PART ########################################################
                

                #read the raw analog data every second.
                
                value = myBoard.analog_read(thermistorPin1)[0]
                value2 = myBoard.analog_read(thermistorPin2)[0]

                #Convert Analog Reading to Voltage
                voltage = value * (5/1023)
                voltage2 = value2 * (5/1023)

                #Find restistance of thermistor
                resistance = (5100/(voltage-1))
                resistance2 = (5100/(voltage2-1))

                internalTemp = -21*math.log((resistance/1000)-0.5)+68
                externalTemp = -21*math.log((resistance2/1000)-0.5)+68

                valueTemp = (internalTemp)
                valueTemp = round(valueTemp, 1)

                valueTemp2 = (externalTemp)
                valueTemp2 = round(valueTemp2, 1)

                tempDisplay = round(valueTemp, 1)
                

                LDRVoltage = myBoard.analog_read(LDRPin)[0]
                if LDRVoltage < 200:
                    pwmMultiplier = 0.5
                    # do LDR pwm STUFF
 #######################################################################################


                if internalTempList[-1] <= 20:
                    tempState = cold

                elif internalTempList[-1] <=30:
                    tempState = normal

                elif internalTempList[-1] > 30:
                    tempState = hot

                if tempCounter == 10:
                    # maintains list of length 60 for past 60 seconds
                    display_7_Seg(tempDisplay)
                    internalTempList.append(valueTemp)
                    if len(internalTempList) > 60:
                        internalTempList.pop(0)
                    print(f"Internal Temperature is: {round(internalTemp,2)} degrees: {tempState}")

                    # maintains list of length 60 for past 60 seconds for LIST 2
                    externalTempList.append(valueTemp2)
                    if len(externalTempList) > 60:
                        externalTempList.pop(0)
                    print(f"External Temperature is: {round(externalTemp,2)} degrees: {tempState}")
                    tempCounter = 0
                    myBoard.pwm_write(safetyLightPin, 255)
                    tempGradient = internalTempList[-1]-externalTempList[-1]
                    print(f'Temp Gradient is {round(tempGradient,2)}')
                    print(f'Fan Speed is {fanSpeed}% , (PWM value = {pwmValue}) \n -------------------------------------- ----')
                    print(f'Current Fan Multiplier: {pwmMultiplier}')

                    if internalTempList[-1] - internalTempList[-2] >= threshold:
                        print(" Rapid increase")
                        buzz(myBoard,buzzerPin, sounds["rapidUp"])

                    # if temp drops -5 in 3 second, buzz
                    elif internalTempList[-1] - internalTempList[-2] <= -threshold:
                        print(" Rapid decrease")
                        buzz(myBoard,buzzerPin, sounds["rapidDown"])
                    ################## BUZZER PART #################
                    
                    # if temp rises 5 in 3 second, buzz
                    
                    #################### BUTTON ANALOG PART #################
                elif tempCounter == 5:
                    myBoard.pwm_write(safetyLightPin, 0)
                
                prev = internalTempList[-2]


                
                motorButton = myBoard.analog_read(analogButtonPin)
                #print(myBoard.analog_read(analogButtonPin))
                time.sleep(0.005)
                if motorButton == downButton:
                    pwmMultiplier += 0.05
                elif motorButton == upButton:
                    pwmMultiplier += -0.05
                ########################## ULTRASONIC SENSOR PART ##############################

                ultrasonicSensor = store[0]
                ultrasonicSensorList.append(ultrasonicSensor)
            
                #enable motors
                myBoard.digital_pin_write(motorEnable, 1)


                ################ MOTOR TEMP PART ##########



                #if temp gradient is <10 degrees the fan runs at 100%
                if ultrasonicSensor > 10:
                
                    
                    if tempGradient < -10:
                        myBoard.digital_pin_write(motorEnable, 1)
                        pwmValue = 0 #full speed in spin right
                        fanSpeed = abs((pwmValue-255)/255)*100
                        

                        myBoard.pwm_write(motor1,pwmValue)
                        myBoard.pwm_write(motor2,255)

                    elif tempGradient < 0: 
                        myBoard.digital_pin_write(motorEnable, 1)
                        pwmValue = ((tempGradient/10) * 255)
                        pwmValue = int(pwmValue)
                        pwmValue = abs(pwmValue)
                        pwmValue = pwmValue-255
                        pwmValue = pwmValue * pwmMultiplier

                        fanSpeed = abs((pwmValue-255)/255)*100
                    

                        myBoard.pwm_write(motor1, pwmValue)
                        myBoard.pwm_write(motor2, 255)
                            #temp is below ambient, spin air into room right

                        
                    elif tempGradient > 0:
                        myBoard.digital_pin_write(motorEnable, 1)
                        pwmValue = (tempGradient/10) * 255 - 255
                        abs(pwmValue)
                        pwmValue = int(pwmValue)
                        pwmValue = abs(pwmValue)
                        pwmValue = pwmValue * pwmMultiplier
                        fanSpeed = abs((pwmValue-255)/255)*100
                        

                        myBoard.pwm_write(motor1,255)
                        myBoard.pwm_write(motor2, pwmValue)
                            #spin left
                            #temp is above ambient, spin air out of room left
                    #if temp gradient is >10 degrees fan runs 100%
                    elif tempGradient > 10:
                        myBoard.digital_pin_write(motorEnable, 1)
                        pwmValue = 0 #full speed spin left

                        fanSpeed = abs((pwmValue-255)/255)*100
                        

                        myBoard.pwm_write(motor1, 255)
                        myBoard.pwm_write(motor2,pwmValue)    

                    #if temp gradient is between -10 and 0, the fan speed changes in a continious range.
                    
                    #if temp gradient is between 0 and 10 the fan speed changes in continous range
                   
                    elif tempGradient == 0:
                        #disable motors by suppling enable pin = 0
                        myBoard.digital_pin_write(motorEnable, 0)
                        myBoard.pwm_write(motor1,255)
                        myBoard.pwm_write(motor2, 255)
                elif ultrasonicSensor < 10:
                    print("Safety Interlock Engaged. Move Away!")
                    myBoard.digital_pin_write(motorEnable, 0)
                    myBoard.pwm_write(motor1,255)
                    myBoard.pwm_write(motor2, 255)
        

                tempCounter = tempCounter + 1    # allows everything to run in same polling loop

                ###### sends heartbeat every 1 sec (10 cycles)
                if tempCounter == 10:
                    myBoard.digital_write(timerresetsignal, 1)
                time.sleep(checkRate)

        except KeyboardInterrupt:
            displayMain()
            main()
main()



















# Define Temperaatures


#R2.1.1 Heat states low, normal, high DONE


#The fan operation for these heat states is written below, as G2.2.1 satisfies all the below modules
# G2.1.4 (2+ speed from difference to room set point)
# G2.1.5 (5+ precise motor speeds from difference to set point)

#G2.2.1 Speed based on temperature difference from external temp
# the below code takes the temperature of two different thermistors, and attemps to equalise them.
#ie. if the outside temp is warmer it will warm up the room
#ie. if the outside temp is cooler it will cool the room
#ie. A manual deisred temperature can be achieved by changing the externalTemp list.
  

#def two_thermistor_motor(motor1,motor2,motorEnable,thermistorPin1,thermistorPin2):



#two_thermistor_motor(motor1, motor2, motorEnable, thermistorPin1, thermistorPin2)



# uncomment to run code
#two_speed_motor(motor1 =, motor2 =, motorEnable =)






#notes:
#note that if a pwm is set to 255 the output is no voltage,
#if pwm is set to 0 then the voltage is high
#this means a pwm of 0 = 100%, and 255 = 0% motor speed.
#pin 4 low = motor off, pin 4 high = motors enable

#note: the fan speed does not seem to be the highest possible, i believe this
# is due to resistance losses/poor connections with so many wires
# jiggling around wires seems to adjust the speed sometimes suggesting this :)