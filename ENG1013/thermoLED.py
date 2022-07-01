import time
from pymata4 import pymata4

arduino = pymata4.Pymata4()
arduino.set_pin_mode_pwm_output(17)
try:
    while True:
        for i in range(255):
                arduino.pwm_write(17, i)
                time.sleep(0.1)
except KeyboardInterrupt:
    print("Done")