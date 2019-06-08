package hw2;

public class Random {
    public static void main(String[] args) {
        PercolationFactory pf = new PercolationFactory();
        PercolationStats test = new PercolationStats(10, 5, pf);
        System.out.println(test.mean());
        System.out.println(test.stddev());
    }
}
