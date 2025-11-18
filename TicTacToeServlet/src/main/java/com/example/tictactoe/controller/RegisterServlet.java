package com.example.tictactoe.controller;

import java.io.IOException;
import java.util.HashMap;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.example.tictactoe.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        ServletContext context = getServletContext();
        HashMap<String, String> users = (HashMap<String, String>) context.getAttribute("users");
        if (users == null) {
            users = new HashMap<>();
        }

        users.put(username, password);
        context.setAttribute("users", users);

        response.sendRedirect("login.jsp");
    }
}