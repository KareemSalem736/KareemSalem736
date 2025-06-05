import java.util.Random;
import java.util.Arrays;

public class Benchmark {
    public static void main(String[] args) {
        Random rand = new Random();
        BubbleSort bubbleSort = new BubbleSort();
        QuickSort quickSort = new QuickSort();

        int[] sizes = {100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200};

        for (int size : sizes) {
            for (int i = 0; i < 40; i++) {
                int[] array = new int[size];
                for (int j = 0; j < size; j++) {
                    array[j] = rand.nextInt(10000);
                }

                // QuickSort
                int[] quickCopy = Arrays.copyOf(array, array.length);
                quickSort.sort(quickCopy);
                if (!isSorted(quickCopy)) throw new RuntimeException("QuickSort failed on size " + size);
                System.out.println("QuickSort - Size: " + size + " Time: " + quickSort.getTime() + " Count: " + quickSort.getCount());

                // BubbleSort
                int[] bubbleCopy = Arrays.copyOf(array, array.length);
                bubbleSort.sort(bubbleCopy);
                if (!isSorted(bubbleCopy)) throw new RuntimeException("BubbleSort failed on size " + size);
                System.out.println("BubbleSort - Size: " + size + " Time: " + bubbleSort.getTime() + " Count: " + bubbleSort.getCount());
            }
        }
    }
}

class BubbleSort extends AbstractSort {
    @Override
    public void sort(int[] array) {
        int temp;
        startSort();
        for (int i = 0; i < array.length - 1; i++) {
            for (int j = 0; j < array.length - i - 1; j++) {
                if (array[j] > array[j + 1]) {
                    temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
                incrementCount();
            }
        }
        endSort();
    }
}

class QuickSort extends AbstractSort {
    @Override
    public void sort(int[] array) {
        startSort();
        quickSort(array, 0, array.length - 1);
        endSort();
    }
    private void quickSort(int[] array, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(array, low, high);
            quickSort(array, low, pivotIndex - 1);
            quickSort(array, pivotIndex + 1, high);
        }
    }

    private int partition(int[] array, int low, int high) {
        int pivot = array[high];
        int i = low - 1;
        for (int j = low; j < high; j++) {
            incrementCount();
            if (array[j] < pivot) {
                i++;
                swap(array, i, j);
            }
        }
        swap(array, i + 1, high);
        return i + 1;
    }

        private void swap(int[] array, int i, int j) {
            if (i != j) {
                int temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
        }
    }

abstract class AbstractSort {

    private int count;
    private long startTime;
    private long endTime;

    public abstract void sort(int[] array);

    void startSort() {
        count = 0;
        startTime = System.nanoTime();
    }

    void endSort() {
        endTime = System.nanoTime();
    }

    void incrementCount() {
        count++;
    }

    public int getCount() {
        return count;
    }

    public long getTime() {
        return endTime - startTime;
    }
}

private static boolean isSorted(int[] array) {
    for (int i = 1; i < array.length; i++) {
        if (array[i - 1] > array[i]) return false;
    }
    return true;
}
