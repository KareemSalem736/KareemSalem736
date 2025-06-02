import java.util.ArrayList;
import java.util.List;

public class Benchmark{
    public static void main(String[] args) {
    System.out.println("Hello World");
    List<Integer> bubble = new ArrayList<>();
    bubbleSort(bubble);
    System.out.println(bubble);
    }
    public List bubbleSort(List bubble) {
        for (int i = 0; i < 5; i++) {
            bubble.add(i);
        }
        return bubble;
    }
}
  
