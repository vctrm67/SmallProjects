package hw4.puzzle;
import edu.princeton.cs.algs4.MinPQ;
import java.util.*;

public class Solver2 {
    private class searchNode implements WorldState{
        public WorldState node;
        public int moveCount;
        public WorldState pNode;
        private int distance;

        private searchNode (WorldState a, int b, WorldState c) {
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
        public Iterable<WorldState> neighbors() {
            return node.neighbors();
        }
    }

    private class distanceComparator implements Comparator<searchNode> {
        public int compare(searchNode a, searchNode b) {
            int totalDistance_a = a.moveCount + a.distance;
            int totalDistance_b = b.moveCount + b.distance;
            return totalDistance_a - totalDistance_b;
        }
    }

    private MinPQ<searchNode> queue;
    private HashMap<WorldState, searchNode> key;
    private searchNode currentNode;

    public Solver2(WorldState initial) {
        queue = new MinPQ<>(new distanceComparator());
        currentNode = new searchNode(initial, 0, null);
        key = new HashMap<>();

        queue.insert(currentNode);
        key.put(initial, currentNode);
        int size = 0;

        while (!currentNode.isGoal()) {
            currentNode = queue.min();
            queue.delMin();
            Iterable<WorldState> LoN = currentNode.neighbors();
            if (LoN != null) {
                Iterator<WorldState> neighbors = LoN.iterator();
                while (neighbors.hasNext()) {
                    WorldState nearest = neighbors.next();
                    if (!key.containsKey(nearest)) {
                        searchNode neighbor = new searchNode(nearest, currentNode.moveCount + 1, currentNode.node);
                        key.put(nearest, neighbor);
                        queue.insert(neighbor);
                    } else {
                        searchNode neighbor = key.get(nearest);
                        if (neighbor.moveCount > (currentNode.moveCount + 1)) {
                            neighbor.moveCount = currentNode.moveCount + 1;
                            neighbor.pNode = currentNode.node;
                            queue.insert(neighbor);
                        }
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
            pastNode = key.get(pastNode.pNode);
        }
        return solution;
    }

}

/*
public class Solver {

    private MinPQ<WorldState> minpq;
    private List<WorldState> key;
    private List<Integer> distTo;
    private List<Integer> edgeTo;
    private int i;

    public Solver(WorldState initial) {

        minpq = new MinPQ<>();
        distTo = new ArrayList<>();
        edgeTo = new ArrayList<>();
        key = new ArrayList<>();
        i = 0;

        minpq.insert(initial);
        key.add(0, initial);

        while (!initial.isGoal()) {
            WorldState min = minpq.min();
            Iterable<WorldState> neighbors = min.neighbors();
        }

        minpq.insert(initial);
        int hash  = initial.hashCode();

        minpq.delMin();
    }

    private void priorityAdd(WorldState initial, WorldState neighbor){
        int initialKey = key.indexOf(initial);
        int item = key.indexOf(neighbor);
    }
 */