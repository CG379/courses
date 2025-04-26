import time
from pymata4 import pymata4

board = pymata4.Pymata4()
motorPin = 7
board.set_pin_mode_digital_output(motorPin)
def motor_test(microC,cPin):
    #for circuit 4 test 1
    microC.digital_write(cPin,1)
    #on for two seconds
    time.sleep(2)
    microC.digital_write(cPin,0)
    #off for two seconds
    time.sleep(2)
    #TODO uncomment only this line to run test 2
    #microC.pwm_write(cPin,128)
    #bonus: vary the pwm value and see what happens to the motor
    #TODO uncomment only this line to run test 3
    #microC.digital_write(cPin,1)

def buzzer_test(microC,cPin):
    #for experiment B
    microC.digital_write(cPin,1)
    #cycle on and off every 500ms
    time.sleep(500e-3)
    microC.digital_write(cPin,0)
    #cycle every 500ms
    time.sleep(500e-3)
    #TODO comment the section above, and uncomment this line
    # for experiment C:
    #microC.pwm_write(cPin,128)
    #TODO change the value (128) to a new value between 0-255


#TODO set up the Arduino and start a polling loop that can be
# interrupted by ctrl-c. If you can't remember how to do it,
# the structure is provided in the polling_loop.py example.

#TODO call buzzer_test (circuits 1&2) or motor_test (circuits 3&4)
# functions inside the polling loop

#Note: the syntax for a PWM pin setup is:
#board.set_pin_mode_pwm_output()

try:
    t_end = time.time() + 10
    while time.time() < t_end:
        motor_test(board,motorPin)
except KeyboardInterrupt:
    print("\nDone")
