import matplotlib.pyplot as plt

temps = [5,23,27,1,3,6,5]
times = [i for i in range(len(temps))]
plt.plot(times,temps)
plt.savefig("temp_time.png")