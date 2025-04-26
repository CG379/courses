def Greet():
    name = input("What is your name?\n")
    print(f"Hello {name}")

def Time():
    times = [(1200, "Good morning"), (1600, "Good afternoon"), 
    (1900, "Good evening"), (2400, "Good night")]
    time = input("What is the time?\n")
    time = time.split(":")
    time = int(time[0]) * 100
    for i in range(len(times)):
        if time < times[i][0]:
            print(times[i][1])
            return

def Grade():
    grades = [(49.9, "Fail"), (59.9, "Pass"), (69.9, "Credit"), (79.9, "Distinction"), 
    (100, "High Distinction")]
    mark = input("What is your mark?\n")
    mark = int(mark)
    for i in range(len(grades)):
        if mark <= grades[i][0]:
            print(grades[i][1])
            return

def BMI():
    bmi = [(18.5, "Underweight"), (25.0, "Normal Weight"), (30.0, "Overweight"), 
    (float("inf"), "Obesity"),]
    weight = float(input("What is your weight?\n"))
    height = float(input("What is your height?\n"))
    userBMI = weight/(height**2)
    for i in range(len(bmi)):
        if userBMI < bmi[i][0]:
            print(bmi[i][1])
            print(userBMI)
            return



