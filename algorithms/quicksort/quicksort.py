import random

# QuickSort with step recording
def quicksort(arr):
    steps = []  # stores the array at each step for visualization

    def _quicksort(p, r):
        if p >= r:
            return
        i = random.randint(p, r)
        arr[p], arr[i] = arr[i], arr[p]
        pivot = arr[p]
        steps.append((arr.copy(), p, r, p))  # before partition

        q = partition(p, r)
        _quicksort(p, q - 1)
        _quicksort(q + 1, r)

    def partition(p, r):
        x = arr[p]
        q = p
        for s in range(p + 1, r + 1):
            if arr[s] < x:
                q += 1
                arr[q], arr[s] = arr[s], arr[q]
            steps.append((arr.copy(), p, r, q))
        arr[p], arr[q] = arr[q], arr[p]
        steps.append((arr.copy(), p, r, q))  # after partition
        return q

    _quicksort(0, len(arr) - 1)
    return steps

import matplotlib.pyplot as plt
import matplotlib.animation as animation

def visualize_quicksort(arr):
    steps = quicksort(arr)

    fig, ax = plt.subplots()
    bar_rects = ax.bar(range(len(arr)), arr, align="edge")

    ax.set_title("QuickSort Visualization")
    ax.set_xlim(0, len(arr))
    ax.set_ylim(0, max(arr) + 1)

    def update(frame):
        array, p, r, pivot = steps[frame]
        for rect, val in zip(bar_rects, array):
            rect.set_height(val)
            rect.set_color("skyblue")
        bar_rects[pivot].set_color("red")  # pivot in red
        for i in range(p, r + 1):
            bar_rects[i].set_color("lightgreen")  # active subarray in green

    ani = animation.FuncAnimation(fig, update, frames=len(steps), interval=500, repeat=False)
    plt.show()

arr = [random.randint(1, 20) for _ in range(10)]
visualize_quicksort(arr)
