package com.example.tictactoe.controller;

import java.io.IOException;
import com.example.tictactoe.model.UserDatabase;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Save user in memory
        UserDatabase.addUser(username, password);

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}

