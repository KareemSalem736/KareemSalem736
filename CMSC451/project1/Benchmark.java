/*
Kareem Salem    CMSC451     Project 1   06/05/2025 
 */

import java.util.Random;
import java.util.Arrays;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Benchmark {
    public static void main(String[] args) {
        Random rand = new Random();
        BubbleSort bubbleSort = new BubbleSort();
        QuickSort quickSort = new QuickSort();

        // JVM Warm-up
        System.out.println("Warming up JVM...");
        for (int i = 0; i < 10; i++) {
            int[] warmup = rand.ints(1000, 0, 10000).toArray(); // 1000 elements of random data

            // QuickSort warm-up
            int[] quickCopy = Arrays.copyOf(warmup, warmup.length);
            quickSort.sort(quickCopy);

            // BubbleSort warm-up
            int[] bubbleCopy = Arrays.copyOf(warmup, warmup.length);
            bubbleSort.sort(bubbleCopy);
        }
        System.out.println("Warm-up complete. Beginning benchmark...");


        String quickSortFile = "quickSort.txt";
        String bubbleSortFile = "bubbleSort.txt";

        int[] sizes = {100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200};

        try (
            BufferedWriter quickWriter = new BufferedWriter(new FileWriter(quickSortFile));
            BufferedWriter bubbleWriter = new BufferedWriter(new FileWriter(bubbleSortFile));
        ) {
            for (int size : sizes) {
                StringBuilder quickLine = new StringBuilder(size + " ");
                StringBuilder bubbleLine = new StringBuilder(size + " ");

                for (int i = 0; i < 40; i++) {
                    int[] array = new int[size];
                    for (int j = 0; j < size; j++) {
                        array[j] = rand.nextInt(10000);
                    }

                    // QuickSort
                    int[] quickCopy = Arrays.copyOf(array, array.length);
                    quickSort.sort(quickCopy);
                    if (!isSorted(quickCopy)) throw new RuntimeException("QuickSort failed on size " + size);
                    quickLine.append(quickSort.getCount()).append(" ").append(quickSort.getTime()).append(" ");

                    // BubbleSort
                    int[] bubbleCopy = Arrays.copyOf(array, array.length);
                    bubbleSort.sort(bubbleCopy);
                    if (!isSorted(bubbleCopy)) throw new RuntimeException("BubbleSort failed on size " + size);
                    bubbleLine.append(bubbleSort.getCount()).append(" ").append(bubbleSort.getTime()).append(" ");
                }
                quickWriter.write(quickLine.toString().trim());
                quickWriter.newLine();

                bubbleWriter.write(bubbleLine.toString().trim());
                bubbleWriter.newLine();
            }
            System.out.println("Benchmarking complete, Data written to files.");
        } catch (IOException e) {
            System.out.println("An error occurred writing the output files.");
            e.printStackTrace();
        }
    }

    private static boolean isSorted(int[] array) {
        for (int i = 1; i < array.length; i++) {
            if (array[i - 1] > array[i]) return false;
        }
        return true;
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
