from pymata4 import pymata4
import time

board = pymata4.Pymata4()
board.set_pin_mode_analog_input(0)
board.set_pin_mode_analog_input(5)

def LDRVoltage():
    while True:
        try:
            v1 = board.analog_read(1)
            v2 = board.analog_read(5)
            print(v2[0]-v1[0])
        except KeyboardInterrupt:
            break
        time.sleep(0.5)
    return

LDRVoltage()