class MaxHeap:
    def __init__(self):
        self.heap = []
    
    def insert(self, value):
        self.heap.append(value)
        self._heapify_up(len(self.heap) - 1)
    
    def extract_max(self):
        if len(self.heap) == 0:
            return None
        max_val = self.heap[0]
        self.heap[0] = self.heap.pop()
        self._heapify_down(0)
        return max_val
    
    def _heapify_up(self, index):
        parent = (index - 1)
        if index > 0 and self.heap[index] > self.heap[parent]:
            self.heap[index], self.heap[parent] = self.heap[parent], self.heap[index]
            self._heapify_up(parent)
    
    def _heapify_down(self, index):
        left = 2 * index + 1
        right = 2 * index + 2
        largest = index

        if left < len(self.heap) and self.heap[left] > self.heap[largest]:
            largest = left
        if right < len(self.heap) and self.heap[right] > self.heap[largest]: 
            largest = right
        if largest != index: 
            self.heap[index], self.heap[largest] = self.heap[largest], self.heap[index]
            self._heapify_down(largest)
    
    def __str__(self):
        return str(self.heap)

h = MaxHeap()
h.insert(10)
h.insert(4)
h.insert(15) 
h.insert(20)

print("Heap: ", h)
print("Max: ", h.extract_max)
print("Heap after extract: ", h)