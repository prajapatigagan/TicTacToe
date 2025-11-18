package com.example.tictactoe.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/guestGame")
public class GuestGameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        // Default guest player names
        session.setAttribute("player1", "Guest Player");
        session.setAttribute("player2", "Player 2");

        response.sendRedirect("game");
    }
}
