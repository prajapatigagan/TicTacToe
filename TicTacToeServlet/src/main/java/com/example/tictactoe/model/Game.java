package com.example.tictactoe.model;

public class Game {
    private final char[][] board;
    private char currentPlayer;

    public Game() {
        board = new char[3][3];
        reset();
    }

    public boolean makeMove(int r, int c) {
        if (r < 0 || r > 2 || c < 0 || c > 2) return false;
        if (board[r][c] != '-') return false;
        board[r][c] = currentPlayer;
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        return true;
    }

    public char checkWinner() {
        for (int i = 0; i < 3; i++)
            if (board[i][0] != '-' && board[i][0] == board[i][1] && board[i][1] == board[i][2])
                return board[i][0];
        for (int i = 0; i < 3; i++)
            if (board[0][i] != '-' && board[0][i] == board[1][i] && board[1][i] == board[2][i])
                return board[0][i];
        if (board[0][0] != '-' && board[0][0] == board[1][1] && board[1][1] == board[2][2])
            return board[0][0];
        if (board[0][2] != '-' && board[0][2] == board[1][1] && board[1][1] == board[2][0])
            return board[0][2];
        return '-';
    }

    public boolean isBoardFull() {
        for (int i = 0; i < 3; i++)
            for (int j = 0; j < 3; j++)
                if (board[i][j] == '-') return false;
        return true;
    }

    public void reset() {
        for (int i = 0; i < 3; i++)
            for (int j = 0; j < 3; j++)
                board[i][j] = '-';
        currentPlayer = 'X';
    }

    public char[][] getBoard() { return board; }
    public char getCurrentPlayer() { return currentPlayer; }
}
