package com.example.tictactoe.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/restart")
public class RestartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            // हमेशा नई game बनानी है → पुरानी हटाओ
            session.removeAttribute("game");

            // keepPlayers=null ⇒ new players; names भी हटेंगे
            String keepPlayers = req.getParameter("keepPlayers");
            if (!"true".equals(keepPlayers)) {
                session.removeAttribute("player1");
                session.removeAttribute("player2");
            }
        }
        String keepPlayers = req.getParameter("keepPlayers");
        if ("true".equals(keepPlayers)) {
            // same players के साथ game page
            resp.sendRedirect(req.getContextPath() + "/game");
        } else {
            // new players भरने के लिए आपके existing playerNames.jsp पर जाएँ
            resp.sendRedirect(req.getContextPath() + "/playerNames.jsp");
        }
    }
}