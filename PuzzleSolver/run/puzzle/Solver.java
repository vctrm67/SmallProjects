package hw4.puzzle;
import edu.princeton.cs.algs4.MinPQ;
import java.util.*;

public class Solver {
    private class searchNode implements WorldState{
        public WorldState node;
        public int moveCount;
        public searchNode pNode;
        private int distance;

        private searchNode (WorldState a, int b, searchNode c) {
            node = a;
            moveCount = b;
            pNode = c;
            distance = a.estimatedDistanceToGoal();
        }

        @Override
        public int estimatedDistanceToGoal() {
            return distance;
        }

        @Override
        public Iterable<WorldState> neighbors() {return node.neighbors();}
    }

    private class distanceComparator implements Comparator<searchNode> {
        public int compare(searchNode a, searchNode b) {
            int totalDistance_a = a.moveCount + a.distance;
            int totalDistance_b = b.moveCount + b.distance;
            return totalDistance_a - totalDistance_b;
        }
    }

    private MinPQ<searchNode> queue;
    private searchNode currentNode;

    public Solver(WorldState initial) {
        queue = new MinPQ<>(new distanceComparator());
        currentNode = new searchNode(initial, 0, null);

        queue.insert(currentNode);
        Iterable<WorldState> neighbors;
        int size = 0;

        while (!currentNode.isGoal()) {
            currentNode = queue.min();
            queue.delMin();
            neighbors = currentNode.neighbors();

            if (neighbors != null) {
                for (WorldState i : neighbors) {
                    if (currentNode.pNode == null || !currentNode.pNode.node.equals(i)) {
                        queue.insert(new searchNode(i, currentNode.moveCount + 1, currentNode));
                    }
                }
            }
        }
    }

    public int moves() { return currentNode.moveCount; }

    public Iterable<WorldState> solution() {
        List<WorldState> solution = new ArrayList<>();
        searchNode pastNode = currentNode;

        while (pastNode != null) {
            solution.add(0, pastNode.node);
            pastNode = pastNode.pNode;
        }

        return solution;
    }

}
