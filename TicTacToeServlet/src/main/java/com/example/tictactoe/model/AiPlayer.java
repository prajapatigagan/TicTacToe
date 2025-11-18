package com.example.tictactoe.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class AiPlayer {

    public enum Difficulty { EASY, MEDIUM, HARD }

    private static final Random RNG = new Random();

    public static int[] bestMove(char[][] board, char ai, char human, Difficulty level) {
        switch (level) {
            case EASY:   return randomMove(board);
            case MEDIUM: return mediumMove(board, ai, human);
            case HARD:   return minimaxBest(board, ai, human);
            default:     return randomMove(board);
        }
    }

    // ---------- EASY: random empty ----------
    private static int[] randomMove(char[][] b) {
        List<int[]> moves = empties(b);
        return moves.isEmpty() ? null : moves.get(RNG.nextInt(moves.size()));
    }

    // ---------- MEDIUM: win > block > center > corner > random ----------
    private static int[] mediumMove(char[][] b, char ai, char human) {
        // 1) Can win now?
        int[] m = findWinningMove(b, ai);
        if (m != null) return m;

        // 2) Need to block?
        m = findWinningMove(b, human);
        if (m != null) return m;

        // 3) Center
        if (b[1][1] == '-') return new int[]{1,1};

        // 4) Any corner
        int[][] corners = {{0,0},{0,2},{2,0},{2,2}};
        for (int[] c : corners) if (b[c[0]][c[1]] == '-') return c;

        // 5) Random
        return randomMove(b);
    }

    private static int[] findWinningMove(char[][] b, char player) {
        List<int[]> moves = empties(b);
        for (int[] mv : moves) {
            b[mv[0]][mv[1]] = player;
            if (winner(b) == player) { b[mv[0]][mv[1]]='-'; return mv; }
            b[mv[0]][mv[1]]='-';
        }
        return null;
    }

    // ---------- HARD: perfect play (minimax) ----------
    private static int[] minimaxBest(char[][] b, char ai, char human) {
        int bestScore = Integer.MIN_VALUE;
        int[] best = null;
        for (int[] mv : empties(b)) {
            b[mv[0]][mv[1]] = ai;
            int score = minimax(b, false, ai, human, 0);
            b[mv[0]][mv[1]] = '-';
            if (score > bestScore) { bestScore = score; best = mv; }
        }
        return best != null ? best : randomMove(b);
    }

    private static int minimax(char[][] b, boolean isMax, char ai, char human, int depth) {
        char w = winner(b);
        if (w == ai)   return 10 - depth;
        if (w == human) return depth - 10;
        if (isFull(b))  return 0;

        if (isMax) {
            int best = Integer.MIN_VALUE;
            for (int[] mv : empties(b)) {
                b[mv[0]][mv[1]] = ai;
                best = Math.max(best, minimax(b, false, ai, human, depth+1));
                b[mv[0]][mv[1]] = '-';
            }
            return best;
        } else {
            int best = Integer.MAX_VALUE;
            for (int[] mv : empties(b)) {
                b[mv[0]][mv[1]] = human;
                best = Math.min(best, minimax(b, true, ai, human, depth+1));
                b[mv[0]][mv[1]] = '-';
            }
            return best;
        }
    }

    // ---------- helpers ----------
    private static List<int[]> empties(char[][] b) {
        List<int[]> list = new ArrayList<>();
        for (int i=0;i<3;i++)
            for (int j=0;j<3;j++)
                if (b[i][j]=='-') list.add(new int[]{i,j});
        return list;
    }

    private static boolean isFull(char[][] b) {
        for (int i=0;i<3;i++)
            for (int j=0;j<3;j++)
                if (b[i][j]=='-') return false;
        return true;
    }

    private static char winner(char[][] b) {
        for (int i=0;i<3;i++)
            if (b[i][0] != '-' && b[i][0]==b[i][1] && b[i][1]==b[i][2]) return b[i][0];
        for (int i=0;i<3;i++)
            if (b[0][i] != '-' && b[0][i]==b[1][i] && b[1][i]==b[2][i]) return b[0][i];
        if (b[0][0] != '-' && b[0][0]==b[1][1] && b[1][1]==b[2][2]) return b[0][0];
        if (b[0][2] != '-' && b[0][2]==b[1][1] && b[1][1]==b[2][0]) return b[0][2];
        return '-';
    }
}
