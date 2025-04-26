import time
from pymata4 import pymata4

# Board and pin setup
myBoard = pymata4.Pymata4()
buzzerPin = 18

# Different types of sounds avaliable (Freq, length of sound (ms), length of delay after sound (ms))
sounds = {"rapidUp" : [[100, 100, 30], [50, 100, 30], [10, 100, 30]],
        "rapidDown" : [[100, 100, 50]]
}


myBoard.set_pin_mode_pwm_output(buzzerPin)

# Frequency, length note is played in ms, length of pause after ms
def playNote(note, noteDuration, delayDuration, myBoard, buzzerPin):
    myBoard.pwm_write(buzzerPin, note)
    time.sleep(noteDuration/(10**3))
    myBoard.pwm_write(buzzerPin, 0)
    time.sleep(delayDuration/(10**3))

# Play the sound with the specified board and puzzer pin
def buzz(board, buzzerPin, sound):
    for note in sound:
        playNote(note[0], note[1], note[2], board, buzzerPin)

# Example of temp input
temps = [25,25,24,24,25,30,31,31,30,25,20,21,22,23,24,25]
# Threshold increase for the buzzer to go of can be changed to match the motor threshold
threshold = 5

# Simulate a stream of input from the buzzer, separtated by 1 sencond
# Delay of results dependant on rate of temp check from the thermistor

try:
    prev = temps[-2]
    print(temps[-1], end = "")
    if temps[-1] - prev >= threshold:
        print(" Rapid increase")
        buzz(myBoard,buzzerPin, sounds["rapidUp"])
    elif temps[-1] - prev <= -threshold:
        print(" Rapid decrease")
        buzz(myBoard,buzzerPin, sounds["rapidDown"])

except KeyboardInterrupt:
    # Because I can
    #buzz(myBoard,buzzerPin, sounds["Music"])
    # keyboard interrupt to be replaced with safety interlock value condition in final version  
    playNote(0, 0, 0, myBoard, buzzerPin)
