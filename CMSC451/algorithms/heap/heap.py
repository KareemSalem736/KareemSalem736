class MaxHeap:
    def __init__(self):
        self.heap = []
    
    def insert(self, value):
        self.heap.append(value)
        self._heapifyup(len(self.heap) - 1)
    
    def extract_max(self):
        if len(self.heap) == 0:
            return None
        max_val = self.heap[0]
        self.heap[0] = self.heap.pop()
        self._heapifydown(0)
        return max_val
    
    def _heapifyup(self, index):
        parent = (index - 1) // 2
        if index > 0 and self.heap[index] > self.heap[parent]:
            self.heap[index], self.heap[parent] = self.heap[parent], self.heap[index]
            self._heapifyup(parent)
    
    def _heapifydown(self, index):
        left = 2 * index + 1
        right = 2 * index + 2
        largest = index

        if left < len(self.heap) and self.heap[left] > self.heap[largest]:
            largest = left
        if right < len(self.heap) and self.heap[right] > self.heap[largest]: 
            largest = right
        if largest != index: 
            self.heap[index], self.heap[largest] = self.heap[largest], self.heap[index]
            self._heapifydown(largest)
    
    def __str__(self):
        return str(self.heap)

h = MaxHeap()
h.insert(10)
h.insert(4)
h.insert(15) 
h.insert(20)

print("Heap: ", h)
print("Max: ", h.extract_max())
print("Heap after extract: ", h)

class MinHeap:
    def __init__(self):
        self.heap = []

    def insert(self, value):
        self.heap.append(value)
        self._heapify_up(len(self.heap) - 1)

    def extract_min(self):
        if len(self.heap) == 0:
            return None
        min_val = self.heap[0]
        self.heap[0] = self.heap.pop()
        self._heapify_down(0)
        return min_val

    def _heapify_up(self, index):
        parent = (index - 1) // 2
        if index > 0 and self.heap[index] < self.heap[parent]:
            self.heap[index], self.heap[parent] = self.heap[parent], self.heap[index]
            self._heapify_up(parent)

    def _heapify_down(self, index):
        left = 2 * index + 1
        right = 2 * index + 2
        smallest = index

        if left < len(self.heap) and self.heap[left] < self.heap[smallest]:
            smallest = left
        if right < len(self.heap) and self.heap[right] < self.heap[smallest]:
            smallest = right
        if smallest != index:
            self.heap[index], self.heap[smallest] = self.heap[smallest], self.heap[index]
            self._heapify_down(smallest)

    def __str__(self):
        return str(self.heap)

# Test
m = MinHeap()
m.insert(10)
m.insert(4)
m.insert(15)
m.insert(2)

print("Heap: ", m)
print("Min: ", m.extract_min())
print("Heap after extract: ", m)

import matplotlib.pyplot as plt
import networkx as nx

def visualize_heap(heap_list, title="Heap"):
    G = nx.DiGraph()

    def add_edges(index):
        left = 2 * index + 1
        right = 2 * index + 2
        if left < len(heap_list):
            G.add_edge(heap_list[index], heap_list[left])
            add_edges(left)
        if right < len(heap_list):
            G.add_edge(heap_list[index], heap_list[right])
            add_edges(right)

    if heap_list:
        add_edges(0)

    pos = hierarchy_pos(G, heap_list[0])
    plt.figure(figsize=(8, 5))
    nx.draw(G, pos, with_labels=True, node_size=1000, node_color="skyblue", font_size=14, font_weight="bold")
    plt.title(title)
    plt.show()

# Helper function to layout nodes in a tree shape
def hierarchy_pos(G, root, width=1.0, vert_gap=0.2, vert_loc=0, xcenter=0.5, pos=None, parent=None):
    if pos is None:
        pos = {root: (xcenter, vert_loc)}
    else:
        pos[root] = (xcenter, vert_loc)
    children = list(G.successors(root))
    if len(children) != 0:
        dx = width / len(children)
        nextx = xcenter - width / 2 - dx / 2
        for child in children:
            nextx += dx
            pos = hierarchy_pos(G, child, width=dx, vert_gap=vert_gap,
                                vert_loc=vert_loc - vert_gap, xcenter=nextx,
                                pos=pos, parent=root)
    return pos

visualize_heap(h.heap, title="Max Heap")
visualize_heap(h.heap, title="Min Heap")
