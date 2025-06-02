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
    stack = [1, 2, 3, 4, 5] # CREATE - basic list used as stack

    print(stack)
    stack.append(100) # INSERT - push element onto the top of the stack

    stack.pop() # DELETE - pop element from the top of the stack
    print(stack)

#Deques
def Deque():
    d = deque([1, 2, 3, 4, 5])

    print(d)
    d.append(100) # INSERT - add to the right end
    d.appendleft(200) # INSERT - add to the left end

    d.pop() # DELETE - remove from right end
    d.popleft()  # DELETE - remove from left end

    d.rotate(3) # ROTATE - shift all elements 3 steps to the right
    print(d)

#queues
from queue import Queue

def Q_Queue():
    q = Queue()

    for i in [1, 2, 3, 4, 5]:
        q.put(i)  # INSERT - enqueue elements

    print(list(q.queue))  # PRINT - view current queue (for debug only, not typical usage)

    q.put(100)  # INSERT - enqueue another element

    print(q.get())  # DELETE - dequeue (removes from front of queue)

    print(q.empty())  # EMPTY CHECK - returns True if queue is empty

    print(list(q.queue))

#Linked Lists
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None
    
    def insertLeft(self, new_data):
        new_node = Node(new_data) #CREATE - new node
        new_node.next = self.head #SET - next for new node becomes the current head
        self.head = new_node # Head now points to the new node
    
    def printList(self):
        temp = self.head #start from the head
        while temp:
            print(temp.data, end=' ') # print the data in the current node
            temp = temp.next # move to the next node
        print() # new line
    
    def insertRight(self, new_data):
        new_node = Node(new_data)
        if self.head is None:
            self.head = new_node # if empty, make new node the head
            return
        last = self.head
        while last.next: # traverse the list to find the last node
            last = last.next
        last.next = new_node # make the new node the next node
    
    def deleteLeft(self):
        if self.head is None:
            return "List is empty"
        self.head = self.head.next #remove head by making the next node head
    
    def deleteRight(self):
        if self.head is None:
            return "List is empty"
        if self.head.next is None:
            self.head = None
            return
        temp = self.head
        while temp.next.next:
            temp = temp.next
        temp.next = None
    
    def search(self, value):
        current = self.head
        position = 0
        while current:
            if current.data == value:
                return f"Value '{ value }' found at positon { position }"
            current = current.next
            position += 1
        return "Value not found"

# Graphs


# Trees

#Tries

#Hash Tables

#start program
if __name__ == '__main__':
    print('Array')
    Array()
    print()

    print("Stack")
    Stack()
    print()

    print("Deque")
    Deque()
    print()

    print("Queue")
    Q_Queue()
    print()

    print("LinkedList")
    list = LinkedList()
    for _ in range(1, 6):
        list.insertLeft(_)
    list.printList()
    print()
    
    list2 = LinkedList()
    for _ in range(1, 6):
        list2.insertRight(_)
    list2.printList()

    list2.deleteLeft()
    list2.deleteRight()
    list2.printList()

    print(list2.search(3))