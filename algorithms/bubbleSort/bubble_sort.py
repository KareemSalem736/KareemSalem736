import matplotlib.pyplot as plt
import matplotlib.animation as animation
import random

def bubble_sort(arr, frames):
    n = len(arr)
    for i in range(n):
        for j in range(n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
            frames.append(arr.copy())

def update(frame):
    plt.cla()
    plt.bar(range(len(frame)), frame, color='blue')

data = [random.randint(1, 100) for _ in range(20)]
frames = [data.copy()]
bubble_sort(data, frames)

fig = plt.figure()
ani = animation.FuncAnimation(fig, update, frames=frames, interval=100)
plt.show()
