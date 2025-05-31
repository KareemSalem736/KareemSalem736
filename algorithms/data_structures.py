#This is for creating data structures in python for practice

#Arrays also known as a list
def Array():
    array = [1, 2, 3, 4, 5]

    print(array)
    array.insert(len(array), 122) #INSERT - if printed, it would print none
    array.append(123) #INSERT - inserts at the end, same as above
    print(array[0]) #GET
    del array[3] #DELETE - can't be printed - removes at index
    array.remove(2) #DELETE - can't be printed - removes at value
    print(len(array)) #SIZE
    print(array)

#Stacks
from collections import deque
def Stack():
    stack = [1, 2, 3, 4, 5]

    print(stack)
    stack.append(100)
    stack.pop()
    print(stack)

#Deques
def Deque():
    d = deque([1, 2, 3, 4, 5])

    print(d)
    d.append(100)
    d.appendleft(200)
    d.pop()
    d.popleft()
    d.rotate(3)
    print(d)

#queues

#Linked Lists

# Trees

# Graphs

#Tries

#Hash Tables

#start program
def main():

    print('Array')
    Array()
    print("\n")

    print("Stack")
    Stack()
    print("\n")

    print("Deque")
    Deque()
    print("\n")

if __name__ == '__main__':
    main()