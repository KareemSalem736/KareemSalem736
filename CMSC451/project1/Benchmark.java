import java.util.Random;

public class Benchmark {
    public static void main(String[] args) {
        Random rand = new Random();
        BubbleSort bubbleSort = new BubbleSort();
        QuickSort quickSort = new QuickSort();
        int[] array = new int[10];

        for (int i = 0; i < array.length; i++) {
            array[i] = rand.nextInt(10000);
        }
        for (int i = 0; i <= 40; i++) {
            quickSort.sort(array);
            quickSort.getCount();
            quickSort.getTime();

            bubbleSort.sort(array);
            bubbleSort.getCount();
            bubbleSort.getTime();
        }
    }
}

class BubbleSort extends AbstractSort {
    public int[] sort(int[] array) {
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
        return array;
    }
}

class QuickSort extends AbstractSort {

}

abstract class AbstractSort {

    private int count;
    private long startTime;
    private long endTime;

    public abstract int[] sort(int[] array);

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