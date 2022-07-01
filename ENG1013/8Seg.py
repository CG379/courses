import time

from pymata4 import pymata4

board = pymata4.Pymata4()
pins = {
"pinA": 6,
"pinB" : 8,
"pinC" : 4,
"pinD" : 2,
"pinE" : 9,
"pinF" : 7,
"pinG" : 5,
"DEC" : 3,
"D0" : 10,
"D1" : 11,
"D2" : 12,
"D3" : 13
}

for pin in pins.values():
    board.set_pin_mode_digital_output(pin)


def displayNone():
    for i in pins.values():
        if i <10:
            board.digital_pin_write(i, 0)


def number(num, place):
    
    try:
        board.digital_pin_write(pins["D" + str(place)], 1)
        
        if num == 0:
            board.digital_pin_write(pins["pinA"], 1)  
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 1)  
            board.digital_pin_write(pins["pinD"], 1)  
            board.digital_pin_write(pins["pinE"], 1)  
            board.digital_pin_write(pins["pinF"], 1)  
            board.digital_pin_write(pins["pinG"], 0)
        elif num == 1:
            board.digital_pin_write(pins["pinA"], 0)  
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 0)   
            board.digital_pin_write(pins["pinE"], 0)   
            board.digital_pin_write(pins["pinF"], 0)   
            board.digital_pin_write(pins["pinG"], 0)
        elif num == 2:
            board.digital_pin_write(pins["pinA"], 1)   
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 0)   
            board.digital_pin_write(pins["pinD"], 1)   
            board.digital_pin_write(pins["pinE"], 1)   
            board.digital_pin_write(pins["pinF"], 0)   
            board.digital_pin_write(pins["pinG"], 1)
        elif num == 3:
            board.digital_pin_write(pins["pinA"], 1)   
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 1)   
            board.digital_pin_write(pins["pinE"], 0)   
            board.digital_pin_write(pins["pinF"], 0)   
            board.digital_pin_write(pins["pinG"], 1)
        elif num == 4:
            board.digital_pin_write(pins["pinA"], 0)   
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 0)   
            board.digital_pin_write(pins["pinE"], 0)   
            board.digital_pin_write(pins["pinF"], 1)   
            board.digital_pin_write(pins["pinG"], 1)
        elif num == 5:
            board.digital_pin_write(pins["pinA"], 1)   
            board.digital_pin_write(pins["pinB"], 0)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 1)   
            board.digital_pin_write(pins["pinE"], 0)   
            board.digital_pin_write(pins["pinF"], 1)   
            board.digital_pin_write(pins["pinG"], 1)
        elif num == 6:
            board.digital_pin_write(pins["pinA"], 1)   
            board.digital_pin_write(pins["pinB"], 0)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 1)   
            board.digital_pin_write(pins["pinE"], 1)   
            board.digital_pin_write(pins["pinF"], 1)   
            board.digital_pin_write(pins["pinG"], 1)
        elif num == 7:
            board.digital_pin_write(pins["pinA"], 1)   
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 0)   
            board.digital_pin_write(pins["pinE"], 0)   
            board.digital_pin_write(pins["pinF"], 0)   
            board.digital_pin_write(pins["pinG"], 0)
        elif num == 8:
            board.digital_pin_write(pins["pinA"], 1)   
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 1)   
            board.digital_pin_write(pins["pinE"], 1)   
            board.digital_pin_write(pins["pinF"], 1)   
            board.digital_pin_write(pins["pinG"], 1)
        elif num == 9:
            board.digital_pin_write(pins["pinA"], 1)   
            board.digital_pin_write(pins["pinB"], 1)   
            board.digital_pin_write(pins["pinC"], 1)   
            board.digital_pin_write(pins["pinD"], 0)   
            board.digital_pin_write(pins["pinE"], 0)   
            board.digital_pin_write(pins["pinF"], 1)   
            board.digital_pin_write(pins["pinG"], 1)
    except:
        print("Error: Invalid inputs")


def writeDigits(n):
    placement = list(map(int, str(n)))
    placement = placement.reverse()
    for i in range(len(placement)):
        board.digital_pin_write(pins["DEC"], 1)
        number(placement[i],i)
    return

try:
    displayNone()
    for i in range(1,5):
        for j in range(10):
            number(j,i)
            time.sleep(0.1)
            displayNone()
    board.shutdown()
except KeyboardInterrupt:
    print("Rip")