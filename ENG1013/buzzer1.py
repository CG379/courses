import time
from pymata4 import pymata4

arduino = pymata4.Pymata4()

buzzerPin = 5

arduino.set_pin_mode_pwm_output(buzzerPin)

for i in range(3):
    