#from termios import B1000000
import time
from pymata4 import pymata4

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

board = pymata4.Pymata4()

D1 = 0
D2 = 1
D3 = 2
D4 = 3
digit = [D1, D2, D3, D4]
codes = ["RED", "YELO", "GREN", "FULL", "EMPT", "HOT", "COLD"]

delayTime = 5 # in s
dataPin = 4 # SER
latchPin = 5 # RCLK
clockPin = 6 # SRCLK
ShiftRegPins = [dataPin, latchPin, clockPin]

for i in range(len(digit)):
    board.set_pin_mode_digital_output(digit[i])

board.set_pin_mode_digital_output(dataPin)
board.set_pin_mode_digital_output(latchPin)
board.set_pin_mode_digital_output(clockPin)

pinLayout = [dataPin, clockPin, D1, D2, D3, D4, latchPin]

# Splits the number into a list of digits and which digit has the decimal place
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
    #TODO this function needs to take an individual segCode (for a segment)
    # and write it to a single digit, using the shift register.
    for i in range(8):
        #TODO compare this to the code from week 5, why do we use << not >>?
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
    if ID == -1:
        pass
    else:
        ardBoard.digital_write(ID,0)
        time.sleep(200e-6)
        #disable output
        ardBoard.digital_write(ID,1)
    ardBoard.digital_write(pins[6],0)

def write_to_4_digits_serial(segCodes,ardBoard,pins,wait,n):
    
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
            n = steralise_alpha(n, segCodes)
            PD = [0] * 4
        except:
            n = [segCodes["E"], segCodes["r"], segCodes["o"], segCodes["r"]]
            PD = [0] * 4
    # Write to specific digit
    write_to_7_seg_series(LEDThermo,ardBoard,pins,pinMask,-1)
    #digit 0:
    write_to_7_seg_series(segCodes[n[3]] + DP[3],ardBoard,pins,pinMask,pins[2])
    
    write_to_7_seg_series(LEDThermo,ardBoard,pins,pinMask,-1)
    #digit 1: 
    write_to_7_seg_series(segCodes[n[2]] + DP[2],ardBoard,pins,pinMask,pins[3])
    
    write_to_7_seg_series(LEDThermo,ardBoard,pins,pinMask,-1)
    #digit 2
    write_to_7_seg_series(segCodes[n[1]] + DP[1],ardBoard,pins,pinMask,pins[4])
    
    write_to_7_seg_series(LEDThermo,ardBoard,pins,pinMask,-1)
    #digit 3:
    write_to_7_seg_series(segCodes[n[0]] + DP[0],ardBoard,pins,pinMask,pins[5])


def display_7_Seg(input):
    write_to_4_digits_serial(numbers,board,pinLayout,delayTime,input)


# Polling loop example
try:
    # Limited to max 4 digit input
    display_7_Seg(1234)
except KeyboardInterrupt:
    print()
    print("Done")

