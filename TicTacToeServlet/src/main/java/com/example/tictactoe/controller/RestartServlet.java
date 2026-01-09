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
            
            session.removeAttribute("game");

            
            String keepPlayers = req.getParameter("keepPlayers");
            if (!"true".equals(keepPlayers)) {
                session.removeAttribute("player1");
                session.removeAttribute("player2");
            }
        }
        String keepPlayers = req.getParameter("keepPlayers");
        if ("true".equals(keepPlayers)) {
        
            resp.sendRedirect(req.getContextPath() + "/game");
        } else {
          
            resp.sendRedirect(req.getContextPath() + "/playerNames.jsp");
        }
    }
}
