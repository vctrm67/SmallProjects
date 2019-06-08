package hw2;
import edu.princeton.cs.introcs.StdRandom;
import edu.princeton.cs.introcs.StdStats;
import java.lang.Math;

public class PercolationStats {

    private double[] stats;
    private int trials;


    public PercolationStats(int N, int T, PercolationFactory pf) {
        if (N <= 0 || T <= 0) {
            throw new IllegalArgumentException();
        }

        trials = T;
        stats = new double[T];

        for (int i = 0; i < T; i += 1) {
            Percolation newPerc = pf.make(N);
            while (newPerc.percolates() == false) {
                int row = StdRandom.uniform(N);
                int column = StdRandom.uniform(N);

                newPerc.open(row, column);
            }

            stats[i] = (newPerc.numberOfOpenSites() / (double) (N * N));
        }


    }// perform T independent experiments on an N-by-N grid

    public double mean() {
        return StdStats.mean(stats);
    }

    public double stddev() {
        return StdStats.stddev(stats);
    }

    public double confidenceLow() {
        double mean = mean();
        double stddev = stddev();
        return (mean - (1.96 * stddev) / java.lang.Math.sqrt(trials));
    }
    public double confidenceHigh() {
        double mean = mean();
        double stddev = stddev();
        return (mean + (1.96 * stddev) / java.lang.Math.sqrt(trials));
    }
}
