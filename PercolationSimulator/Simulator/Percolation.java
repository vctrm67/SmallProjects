package hw2;

import edu.princeton.cs.algs4.WeightedQuickUnionUF;

public class Percolation {

    private int[][] world;
    private WeightedQuickUnionUF groupGrid;
    private WeightedQuickUnionUF waterGrid;
    private int dimension;
    private int OpenSites;

    public Percolation(int N) {
        // The index 0 will represent a closed site
        if (N <= 0) {
            throw new IllegalArgumentException();
        }
        world = new int[N][N];
        groupGrid = new WeightedQuickUnionUF((N * N) + 2);
        waterGrid = new WeightedQuickUnionUF((N * N) + 2);
        dimension = N;
        OpenSites = 0;

        for (int i = 1; i <= N; i += 1) {
            groupGrid.union(((N * N) + 1), (i + (N - 1) * N));
        }
    }

    public void open(int row, int col) {
        if (row > dimension || col > dimension) {
            throw new IndexOutOfBoundsException();
        } else if (!isOpen(row, col)) {
            OpenSites += 1;
        }
        world[row][col] = 1;
        int n1 = col + 1 + (dimension * row);

        if (row == 0) {
            groupGrid.union(0, (col + 1));
            waterGrid.union(0, (col + 1));
        }

        try {
            if (isOpen((row - 1), col)) {
                int n2 = (col + 1) + (dimension * (row - 1));
                groupGrid.union(n1, n2);
                waterGrid.union(n1, n2);
            }
        } catch (Exception a) {}
        try {
            if (isOpen((row + 1), col)) {
                int n2 = (col + 1) + (dimension * (row + 1));
                groupGrid.union(n1, n2);
                waterGrid.union(n1, n2);
            }
        } catch (Exception a) {}
        try {
            if (isOpen(row, (col - 1))) {
                int n2 = (col) + (dimension * row);
                groupGrid.union(n1, n2);
                waterGrid.union(n1, n2);
            }
        } catch (Exception a) {}
        try {
            if (isOpen(row, (col + 1))) {
                int n2 = (col + 2) + (dimension * row);
                groupGrid.union(n1, n2);
                waterGrid.union(n1, n2);
            }
        } catch (Exception a) {}
    }

    public boolean isOpen(int row, int col) {
        if (row > dimension || col > dimension) {
            throw new IndexOutOfBoundsException();
        }
        return world[row][col] == 1;
    }

    public boolean isFull(int row, int col) {
        if (row > dimension || col > dimension) {
            throw new IndexOutOfBoundsException();
        }
        if (isOpen(row, col)) {
            int n1 = col + 1 + (dimension * row);
            return waterGrid.connected(0, n1);
        } else {
            return false;
        }
    }

    public int numberOfOpenSites() {
        return OpenSites;
    }

    public boolean percolates() {
        return groupGrid.connected(0, ((dimension * dimension) + 1));
    }

    public static void main(String[] args) {}

}
