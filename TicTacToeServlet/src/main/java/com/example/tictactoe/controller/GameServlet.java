package com.example.tictactoe.controller;

import java.io.IOException;
import com.example.tictactoe.model.Game;
import com.example.tictactoe.model.AiPlayer;
import com.example.tictactoe.model.AiPlayer.Difficulty;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/game")
public class GameServlet extends HttpServlet {

    private static final String ATTR_AI_ENABLED = "aiEnabled";
    private static final String ATTR_AI_DIFF    = "aiDiff";
    private static final char AI_SYMBOL = 'O';   
    private static final char HUMAN_SYMBOL = 'X';

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        String player1 = req.getParameter("player1");
        String player2 = req.getParameter("player2");

        if (player1 != null && player2 != null) {
            session.setAttribute("player1", player1);
            session.setAttribute("player2", player2);
        }

        String mode = req.getParameter("mode");
        String diff = req.getParameter("difficulty");

        if (mode != null) {
            session.setAttribute(ATTR_AI_ENABLED, "ai".equalsIgnoreCase(mode));
        }
        if (diff != null) {
            try { session.setAttribute(ATTR_AI_DIFF, Difficulty.valueOf(diff.toUpperCase())); }
            catch (IllegalArgumentException ex) { session.setAttribute(ATTR_AI_DIFF, Difficulty.HARD); }
        }

        if (session.getAttribute(ATTR_AI_ENABLED) == null)
            session.setAttribute(ATTR_AI_ENABLED, Boolean.FALSE);

        if (session.getAttribute(ATTR_AI_DIFF) == null)
            session.setAttribute(ATTR_AI_DIFF, Difficulty.HARD);

        if (session.getAttribute("game") == null) {
            session.setAttribute("game", new Game());
        }

        req.getRequestDispatcher("/game.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Game game = (Game) session.getAttribute("game");

        if (game == null) {
            game = new Game();
            session.setAttribute("game", game);
        }

        boolean aiEnabled = Boolean.TRUE.equals(session.getAttribute(ATTR_AI_ENABLED));
        Difficulty diff = (Difficulty) (session.getAttribute(ATTR_AI_DIFF) != null
                ? session.getAttribute(ATTR_AI_DIFF) : Difficulty.HARD);

        String move = req.getParameter("move");

        if (move != null && move.contains(",")) {
            try {
                int r = Integer.parseInt(move.split(",")[0]);
                int c = Integer.parseInt(move.split(",")[1]);
                game.makeMove(r, c);
            } catch (NumberFormatException ignored) {}
        }

        char w = game.checkWinner();

        if (w == '-') {
            if (aiEnabled && !game.isBoardFull() && game.getCurrentPlayer() == AI_SYMBOL) {
                int[] aiMv = AiPlayer.bestMove(game.getBoard(), AI_SYMBOL, HUMAN_SYMBOL, diff);
                if (aiMv != null) game.makeMove(aiMv[0], aiMv[1]);
                w = game.checkWinner();
            }
        }

        // ✅ Winner + loser logic
        if (w != '-') {
            String p1 = (String) session.getAttribute("player1"); 
            String p2 = (String) session.getAttribute("player2"); 

            String winnerName;
            String loserName;

            if (aiEnabled) {
                if (w == HUMAN_SYMBOL) {
                    winnerName = p1;
                    loserName = "Computer";
                } else {
                    winnerName = "Computer";
                    loserName = p1;
                }
            } else {
                winnerName = (w == HUMAN_SYMBOL) ? p1 : p2;
                loserName = (w == HUMAN_SYMBOL) ? p2 : p1;
            }

            req.setAttribute("winner", "🏆 " + winnerName + " won this match!");
            req.setAttribute("loserName", loserName);
        } 
        
        else if (game.isBoardFull()) {
            req.setAttribute("winner", "🤝 It's a Tie!");
        }

        req.getRequestDispatcher("/game.jsp").forward(req, resp);
    }
}


