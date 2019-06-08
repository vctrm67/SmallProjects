package hw4.puzzle;
import edu.princeton.cs.algs4.Queue;

public class Board implements WorldState{

    /** Returns the string representation of the board. 
      * Uncomment this method. */
    public String toString() {
        StringBuilder s = new StringBuilder();
        int N = size();
        s.append(N + "\n");
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                s.append(String.format("%2d ", tileAt(i,j)));
            }
            s.append("\n");
        }
        s.append("\n");
        return s.toString();
    }

    private final int board[][];

    public Board(int[][] tiles) {
        board = new int [tiles.length][tiles.length];
        for (int i = 0; i < tiles.length; i++) {
            for (int j = 0; j < tiles.length; j++) {
                board[i][j] = tiles[i][j];
            }
        }
    }

    public int tileAt(int i, int j) {
        if (i >= board.length || j >= board.length) {
            throw new IndexOutOfBoundsException("Out of bounds");
        }
        return board[i][j];
    }

    public int size() {
        return board.length;
    }

    public Iterable<WorldState> neighbors() {
        Queue<WorldState> neighbors = new Queue<>();
        int hug = size();
        int bug = -1;
        int zug = -1;
        for (int rug = 0; rug < hug; rug++) {
            for (int tug = 0; tug < hug; tug++) {
                if (tileAt(rug, tug) == 0) {
                    bug = rug;
                    zug = tug;
                }
            }
        }
        int[][] ili1li1 = new int[hug][hug];
        for (int pug = 0; pug < hug; pug++) {
            for (int yug = 0; yug < hug; yug++) {
                ili1li1[pug][yug] = tileAt(pug, yug);
            }
        }
        for (int l11il = 0; l11il < hug; l11il++) {
            for (int lil1il1 = 0; lil1il1 < hug; lil1il1++) {
                if (Math.abs(-bug + l11il) + Math.abs(lil1il1 - zug) - 1 == 0) {
                    ili1li1[bug][zug] = ili1li1[l11il][lil1il1];
                    ili1li1[l11il][lil1il1] = 0;
                    Board neighbor = new Board(ili1li1);
                    neighbors.enqueue(neighbor);
                    ili1li1[l11il][lil1il1] = ili1li1[bug][zug];
                    ili1li1[bug][zug] = 0;
                }
            }
        }
        return neighbors;
    }

    public int hamming() {
        int misplaced = 0;
        for (int i = 0; i < (board.length); i += 1) {
            for (int j = 0; j < (board.length); j += 1) {
                if (board[i][j] != 0) {
                    int rowLevel = board[i][j] / board.length;
                    int colLevel = (board[i][j] % board.length) - 1;
                    if (colLevel == -1) {
                        colLevel = board.length - 1;
                        rowLevel = rowLevel - 1;
                    }
                    if (rowLevel != i || colLevel != j) {
                        misplaced += 1;
                    }
                }
            }
        }
        return misplaced;
    }

    public int manhattan() {
        int distance = 0;
        for (int i = 0; i < (board.length); i += 1) {
            for (int j = 0; j < (board.length); j += 1) {
                if (board[i][j] != 0) {
                    int rowLevel = board[i][j] / board.length;
                    int colLevel = (board[i][j] % board.length) - 1;
                    if (colLevel == -1) {
                        colLevel = board.length - 1;
                        rowLevel = rowLevel - 1;
                    }
                    if (rowLevel != i || colLevel != j) {
                        distance += (Math.abs(rowLevel - i) + Math.abs(colLevel - j));
                    }
                }
            }
        }
        return distance;
    }

    public int estimatedDistanceToGoal() {
        return manhattan();
    }

    public boolean equals(Object y) {
        if (y == null) {return false;}
        if (y.getClass() != this.getClass()) {return false;}
        Board z = (Board) y;
        if (z.size() != this.size()) {return false;}

        boolean equal = true;
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board.length; j++) {
                if (this.tileAt(i, j) != z.tileAt(i, j)) {
                    equal = false;
                }
            }
        }
        return equal;
    }
}
